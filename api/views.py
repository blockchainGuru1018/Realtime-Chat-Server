from datetime import datetime, timedelta

from django.conf import settings
from django.contrib.auth import authenticate, login, get_user_model
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from django.contrib.gis.geos.polygon import Polygon
from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework_gis.filters import DistanceToPointFilter
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter
from django.db.models.query import QuerySet
from urllib.parse import urlencode
from django.contrib.gis.geos import Point
from rest_framework.pagination import PageNumberPagination
import traceback
# from django.contrib.gis.geos import GEOSGeometry
import json
import logging
# from django.contrib.gis.db.models import PointField
import requests
import math

from friendship.models import Friend

from twilio.jwt.access_token.grants import VoiceGrant
from twilio.jwt.access_token import AccessToken
from twilio.rest import Client
from twilio.twiml.voice_response import VoiceResponse

from push_notifications.models import APNSDevice
from .models import (PhoneToken, VoiceMessage,
                    CustomUser, LikeMessage,
                    CallInfo, Group, Event, TypeEvent, EventDate, Category, UserFile,
                    send_to_APNSDevices)
from .permissions import (IsAdminOrIsSelf, VoiceMessageIsAdminOrIsSelf,
                            GroupIsAdminOrIsSelf, OwnerIsAdminOrIsSelf)
from .serializers import (
    PhoneTokenCreateSerializer,
    PhoneTokenValidateSerializer,

    UserSerializer,
    UserLikesSerializer,

    VoiceMessageSerializer,
    CallInfoSerializer,
    APNSDeviceSerialier,
    GroupSerialier,
    EventSerializer,
    TypeEventSerialier,
    EventDateSerializer,
    CategorySerialier, UserFileSerialier
)
from .utils import user_detail, str_to_bool, success, failure
from WeaveChat.settings import (
    account_sid, api_key, api_key_secret,
    app_sid,
    push_credential_sid,
    auth_token,
    CALLER_NUMBER,
    google_api_key,
    google_maps_api_url,
    google_place_photo_url,
    ERROR_TRACE_LEVEL
)



logger = logging.getLogger('log')

User = get_user_model()

# account_sid = "ACc16935e5ba641a7fb530cb079d497f0d"
# api_key = "SK193b0e97e74bba83a115cb22ec719b28"
# api_key_secret = "PM8zznWkXWI7WZHXyc2YyWxLIBYR4Xq3"
# app_sid = "APd257f214371e7edfbe1706a5f9c71b06"
# push_credential_sid = "CRd49104844d81299e668869b97ace3cc5"
#
# CALLER_NUMBER='+13345680002'



#
def str_to_point(point_str):
    point_list_str = point_str.split(',')
    point = (float(point_list_str[0].strip()), float(point_list_str[1].strip()))
    return point


def get_geom(point, len_m):
    if type(point).__name__=='str':
        point = str_to_point(point)
    k_lat = 0.000009
    k_long = 0.000013
    top_lat =   point[0] + (len_m * k_lat)
    top_long =  point[1] - (len_m * k_long)
    bot_lat =   point[0] - (len_m * k_lat)
    bot_long =  point[1] + (len_m * k_long)
    bbox = (top_lat, top_long, bot_lat, bot_long)
    # print('get_geom',bbox)
    return  Polygon.from_bbox(bbox)


def get_geom2(point, dist):
    if type(point).__name__=='str':
        point = str_to_point(point)
    mylat = point[0]
    mylon = point[1]
    dist = dist / 1000
    lon1 = mylon-dist/abs(math.cos(math.radians(mylat))*111.0)
    lon2 = mylon+dist/abs(math.cos(math.radians(mylat))*111.0)
    lat1 = mylat+(dist/111.0)
    lat2 = mylat-(dist/111.0)
    bbox = (lat1,lon1,lat2,lon2)
    # print('get_geom2',bbox)
    return  Polygon.from_bbox(bbox)


# Create your views here.
class GenerateOTP(CreateAPIView):
    serializer_class = PhoneTokenCreateSerializer

    def post(self, request, format=None):
        # Get the patient if present or result None.
        ser = self.serializer_class(
            data=request.data,
            context={'request': request}
        )
        if ser.is_valid():
            phone_number = request.data.get('phone_number')
            token = PhoneToken.create_otp_for_number(
                phone_number
            )
            if token:
                phone_token = self.serializer_class(
                    token, context={'request': request}
                )
                data = phone_token.data
                if getattr(settings, 'PHONE_LOGIN_DEBUG', False):
                    data['debug'] = token.otp
                return Response(data)
            return Response({
                'reason': "you can not have more than {n} attempts per day, please try again tomorrow".format(
                    n=getattr(settings, 'PHONE_LOGIN_ATTEMPTS', 10))}, status=status.HTTP_403_FORBIDDEN)
        return Response(
            {'reason': ser.errors}, status=status.HTTP_406_NOT_ACCEPTABLE)


class ValidateOTP(CreateAPIView):
    serializer_class = PhoneTokenValidateSerializer

    def post(self, request, format=None):
        # Get the patient if present or result None.
        ser = self.serializer_class(
            data=request.data, context={'request': request}
        )
        if ser.is_valid():
            pk = request.data.get("pk")
            otp = request.data.get("otp")
            try:
                user = authenticate(request, pk=pk, otp=otp)
                if user:
                    last_login = user.last_login
                login(request, user)
                response = user_detail(user, last_login)
                return Response(response, status=status.HTTP_200_OK)
            except ObjectDoesNotExist:
                return Response(
                    {'reason': "OTP doesn't exist"},
                    status=status.HTTP_406_NOT_ACCEPTABLE
                )
        return Response(
            {'reason': ser.errors}, status=status.HTTP_406_NOT_ACCEPTABLE)





class SearchViewSet(viewsets.ViewSet):
    filter_backends=(DistanceToPointFilter,)

    queryset = User.objects.all()
    trans_list = [
        ('dist', 'radius'),
        ('point', 'location')
    ]

    def get_places(self, args):
        maxwidth = args.pop('maxwidth') if 'maxwidth' in args else None

        for key_el in self.trans_list:
            if key_el in args:
                value = args.pop(key_el[0])
                args[key_el[1]] = value
        args['key'] = google_api_key
        args['query'] = args.get('query') if args.get('query') else 'point'
        url = google_maps_api_url + urlencode(args, doseq=True)
        res = requests.get(url)


        def render_photo_url(photo_reference):
            if photo_reference:
                param = {
                    'maxwidth': maxwidth if maxwidth else 400,
                    'photoreference' : photo_reference,
                    'key': google_api_key
                }
                return google_place_photo_url + urlencode(param, doseq=True)



        data = res.json()
        if 'results' in data:
            for place in data.get('results'):
                if 'photos' in place:
                    for photo in place.get('photos'):
                        photo['photo_reference'] = render_photo_url(photo.get('photo_reference'))

        return data


    def list(self, request):
        filter = {'is_location':True}
        location = request.query_params.get('location')
        radius = request.query_params.get('radius')
        if location and radius:
            filter['location__coveredby'] = get_geom2(location, int(radius))

        if request.query_params.get('query'):
            filter['full_name__icontains'] = request.query_params.get('query')

        self.queryset = User.objects.filter(**filter)
        queryset = self.filter_queryset(self.get_queryset())
        serializer = UserSerializer(queryset, many=True, context={'request': self.request})
        # serializer = UserLikesSerializer(queryset, many=True)

        dict_parm = dict(request.query_params)
        dict_parm = {key:dict_parm[key][0] for key in dict_parm}
        out = {
            'users': serializer.data,
            'places': self.get_places(dict_parm)
        }
        return Response(out)

    def filter_queryset(self, queryset):

        for backend in list(self.filter_backends):
            queryset = backend().filter_queryset(self.request, queryset, self)
        return queryset

    def get_queryset(self):
        queryset = self.queryset
        if isinstance(queryset, QuerySet):
            queryset = queryset.all()
        return queryset

class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = User.objects.all()
    distance_filter_field='location'
    filter_backends=(DistanceToPointFilter,)
    distance_filter_convert_meters = True

    def list(self, request, *args, **kwargs):
        # print('location', request.query_params.get('location'))
        self.permission_classes = [IsAuthenticated, IsAdminOrIsSelf]
        user = request.user





        location = request.query_params.get('location')
        radius = request.query_params.get('radius')
        name = request.query_params.get('name')
        filter = {'is_location':True}

        if location and radius:
            filter['location__coveredby'] = get_geom2(location, int(radius))

        if name:
            filter['full_name__icontains'] = name

        self.queryset = User.objects.filter(**filter).exclude(Q(pk=user.pk) | Q(photo=None))
        return viewsets.ModelViewSet.list(self, request, *args, **kwargs)


    @action(detail=True, methods=['get'])
    def is_blocked(self, request, pk=None):
        value = request.query_params.get('value')
        user = CustomUser.objects.filter(pk=pk).first()
        if user:
            if value is not None:
                user.is_blocked = str_to_bool(value)
                user.save()
            return Response({'status':status.HTTP_200_OK,
                            'message':{'is_blocked': user.is_blocked}},
                            status=status.HTTP_200_OK)
        else:
            return Response({'status':status.HTTP_400_BAD_REQUEST,
                            'message':'user not found'},
                            status=status.HTTP_400_BAD_REQUEST)


    @action(detail=True, methods=['put'])
    def point_update(self, request, pk=None):
        location_str = request.query_params.get('location')
        user = CustomUser.objects.filter(pk=pk).first()
        if user:
            if location_str is not None:
                user.location.coords = str_to_point(location_str)
                user.save()
            return Response({'status':status.HTTP_200_OK,
                            'message':{'location': user.location.coords}},
                            status=status.HTTP_200_OK)
        else:
            return Response({'status':status.HTTP_400_BAD_REQUEST,
                            'message':'user not found'},
                            status=status.HTTP_400_BAD_REQUEST)

    @action(detail=True)
    def likes(self, request, pk=None):
        self.permission_classes = [IsAuthenticated, IsAdminOrIsSelf]
        return viewsets.ModelViewSet.retrieve(self, request, pk)

    @action(detail=False)
    def friends(self, request):
        self.permission_classes = [IsAuthenticated, IsAdminOrIsSelf]
        friends = Friend.objects.friends(request.user)
        self.queryset = friends
        return viewsets.ModelViewSet.list(self, request)

    @action(detail=True, methods=['get'])
    def token(self, request, pk=None):
        user = CustomUser.objects.get(pk=pk)
        token = AccessToken(account_sid, api_key, api_key_secret, identity='user' + str(user.id))
        voice_grant = VoiceGrant(
            outgoing_application_sid=app_sid,
            push_credential_sid=push_credential_sid,
            incoming_allow=True
        )
        token.add_grant(voice_grant)
        return HttpResponse(
            token.to_jwt().decode('utf-8'),
        )

    def get_serializer_class(self):
        if self.action == 'likes':
            return UserLikesSerializer
        return UserSerializer



    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        if getattr(instance, '_prefetched_objects_cache', None):
            instance._prefetched_objects_cache = {}

        return Response(serializer.data)




    def perform_update(self, serializer):
        serializer.save()




class CallViewSet(viewsets.ModelViewSet):
    serializer_class = CallInfoSerializer
    queryset = CallInfo.objects.filter()

    def perform_create(self, serializer):
        serializer.save(from_user=self.request.user)


    @action(detail=False, methods=['get', 'post'])
    def incoming(self, request, pk=None):
        resp = VoiceResponse()
        resp.say("Nala, Congratulations! You have just made your first inbound call! Good bye.")
        return HttpResponse(
            str(resp),
        )

    @action(detail=False, methods=['get', 'post'])
    def place(self, request, pk=None):
        client = Client(api_key, api_key_secret, account_sid)
        if request.method == 'GET':
            to = request.query_params.get('to')
        else:
            to = request.data.get('to')
        call = None
        CALLER_ID = "client:user2"
        incomintCallEndPoint = "http://165.227.38.5:8000/api/call/incoming"
        if to is None or len(to) == 0:
            to='client:Test'
            from_=CALLER_ID
        elif to[0] in '+1234567890' and (len(to) == 1 or to[:1].isgigit()):
            from_=CALLER_NUMBER
        else:
            to='client:' + to
            from_=CALLER_ID
        call = client.calls.create(url=incomintCallEndPoint, to=to, from_=from_)
        return HttpResponse(
            str(call),
        )

    @action(detail=False, methods=['get', 'post'])
    def make(self, request):
        resp = VoiceResponse()
        if request.method == 'GET':
            to = request.query_params.get('to')
            CALLER_ID = request.query_params.get('to')
        else:
            to = request.data.get('to')
            CALLER_ID = request.data.get('From')
        if to is None or len(to) == 0:
            resp.say("Congratulations! You have just made your first call! Good bye.")
        elif to[0] in '+1234567890' and (len(to) == 1 or to[:1].isgigit()):
            resp.dial(callerId=CALLER_NUMBER).number(to)
        else:
            resp.dial(callerId=CALLER_ID).client(to)
        return HttpResponse(
            str(resp),
        )

    @action(detail=False, methods=['get'])
    def recent(self, request, *args, **kwargs):
        client = Client(api_key, api_key_secret, account_sid)
        user = request.user
        userId = 'client:user' + str(user.pk)
        calls = client.calls.list(limit=20, to=userId)
        resp = []
        users = []
        for call in calls:
            if call.from_.find(userId) >= 0 or call.from_.find("client:user") < 0:
                continue
            user_id = int(call.from_[-1])
            if user_id in users:
                continue
            users.append(user_id)
            sender = CustomUser.objects.get(pk=user.pk)
            resp.append({
                'duration': int(call.duration),
                'created': call.end_time.strftime("%Y-%m-%dT%H:%M:%S"),
                'sender': sender.full_name,
                'status': call.status,
                'to_user': user.pk,
                'from_user': user_id,
                'file': '',
                'id': 1,
            })
        return Response(resp)

class VoiceMessageViewSet(viewsets.ModelViewSet):
    serializer_class = VoiceMessageSerializer
    queryset = VoiceMessage.objects.all()
    permission_classes = [
    IsAuthenticated,
    VoiceMessageIsAdminOrIsSelf,
    # IsAdminOrIsSelf
    ]

    def list(self, request, *args, **kwargs):
        try:
            user = request.user
            queryset = VoiceMessage.objects.filter(Q(from_user=user) | Q(to_user=user))
            queryset = queryset.filter(group=None).order_by('-id')
            users = []
            self.queryset = []
            for message in queryset:
                partner = message.from_user if message.to_user == user else message.to_user
                if partner in users:
                    continue
                users.append(partner)
                self.queryset.append(message)

        except Exception as e:
            logger.error(traceback.format_exc(ERROR_TRACE_LEVEL))

        return viewsets.ModelViewSet.list(self, request, args, kwargs)

    @action(detail=True, methods=['post'])
    def like(self, request, pk=None):
        user = request.user
        message = get_object_or_404(VoiceMessage, pk=pk)
        like, created = LikeMessage.objects.get_or_create(message=message, user=user)
        is_like=request.data.get('is_like', False)
        like.is_like = is_like
        like.save()
        try:
            device = APNSDevice.objects.filter(user=message.from_user).last()
            device.send_message("New Like Notification", extra={"type": "like"})
        except:
            pass
        return Response(self.get_serializer(message).data)

    @action(detail=False, methods=['get'])
    def history(self, request, *args, **kwargs):
        with_user = request.query_params.get('with_user')
        user = request.user
        self.queryset = VoiceMessage.objects.filter(
            (Q(from_user=user) & Q(to_user=with_user)) | (Q(to_user=user) & Q(from_user=with_user))).order_by('id')
        return viewsets.ModelViewSet.list(self, request, args, kwargs)

    def perform_create(self, serializer):
        msg = serializer.save(from_user=self.request.user)
        send_to_APNSDevices(msg)



class Pagination(PageNumberPagination):
  page_size = 50
  page_query_param = 'page'
  max_page_size = 50


class GroupMessageViewSet(VoiceMessageViewSet):
    pagination_class = Pagination

    def list(self, request, *args, **kwargs):
        group_id = request.query_params.get('group')
        user = request.user



        queryset = VoiceMessage.objects.filter(Q(group__members=user) | Q(group__creater=user))

        if group_id:
            queryset = queryset.filter(group__id = int(group_id))

        self.queryset = queryset.distinct().order_by('-id')
        return viewsets.ModelViewSet.list(self, request, args, kwargs)


    def perform_create(self, serializer):
        msg = serializer.save(from_user=self.request.user)
        send_to_APNSDevices(msg)


class APNSDeviceViewSet(viewsets.ModelViewSet):
    serializer_class = APNSDeviceSerialier
    queryset = APNSDevice.objects.all()
    permission_classes = [IsAuthenticated, IsAdminOrIsSelf]



class GroupViewSet(viewsets.ModelViewSet):
    pagination_class = Pagination
    serializer_class = GroupSerialier
    queryset = Group.objects.all()
    permission_classes = [
    IsAuthenticated,
    GroupIsAdminOrIsSelf
    ]

    def list(self, request, *args, **kwargs):
        user = request.user
        self.queryset = Group.objects.filter(Q(creater=user) | Q(members=user)).distinct()

        return viewsets.ModelViewSet.list(self, request, args, kwargs)


    def perform_create(self, serializer):
        serializer.save(creater=self.request.user)

    @action(detail=False, methods=['get'])
    def registration(self, request, *args, **kwargs):
        key = request.query_params.get('by_key')
        group = Group.objects.filter(access_key=key).first()
        if group and request.user:
            if group.general_access:
                group.members.add(request.user)
                group.save()
                group_data = GroupSerialier(group).data
                return Response({'status':'ok', 'group': group_data})
        return Response({'status':'no access'}, status=401)





class TypeEventViewSet(viewsets.ModelViewSet):
    serializer_class = TypeEventSerialier
    queryset = TypeEvent.objects.all()


class EventViewSet(viewsets.ModelViewSet):
    days_minus = 10
    days_plus = 30
    serializer_class = EventSerializer
    queryset = Event.objects.all()
    filter_backends = [SearchFilter]
    search_fields = ['title', 'place', 'description']
    filter_set = [
        ('type_name', 'type__name'),
        ('creator_id', 'creator__id'),
        ('party_id', 'party__id'),
        ('room_id', 'room__id'),
        ('created', 'created__contains')
    ]

    def get_custom_filter(self, filter_set, prefix=''):
        qp = self.request.query_params
        filter = {}
        for key in filter_set:
            val = qp.get( key[0] )
            if val:
                filter[f'{prefix}{key[1]}'] = val
        return filter


    def set_start_end_param(self):
        qp = self.request.query_params
        start = qp.get('start', None)
        end = qp.get('end', None)
        curr_date = datetime.now().date()
        self.start = datetime.strptime(start, '%Y-%m-%d').date() if start else curr_date - timedelta(days=self.days_minus)
        self.end = datetime.strptime(end, '%Y-%m-%d').date() if end else  curr_date + timedelta(days=self.days_plus)


    def get_queryset(self):
        self.set_start_end_param()
        filter = self.get_custom_filter(self.filter_set)
        return Event.objects\
                    .filter(Q(start_date__gte=self.start) & Q(start_date__lte=self.end) | Q(dates__date__gte=self.start) & Q(dates__date__lte=self.end) )\
                    .filter(**filter)\
                    .order_by('start_time')\
                    .distinct()


    @action(detail=False, methods=['get'])
    def calendar(self, request, *args, **kwargs):
        self.set_start_end_param()
        filter = self.get_custom_filter(self.filter_set, prefix="event__")
        dates = EventDate.objects.select_related('event__type')\
            .filter(Q(date__gte=self.start) & Q(date__lte=self.end))\
            .filter(**filter)\
            .order_by('date', 'event__start_time')\
            .distinct()
        data_list = EventDateSerializer(dates, many=True).data

        return Response(data_list, status=200)

    @action(detail=True, methods=['get'])
    def dates(self, request, pk=None):
        data_list = EventDate.objects.filter(event__id=pk)\
                            .values_list('date', flat=True).order_by('date')
        return Response(map(str, data_list), status=200)



class CategoryViewSet(viewsets.ModelViewSet):
    serializer_class = CategorySerialier
    queryset = Category.objects.all()
    permission_classes = [IsAuthenticated, OwnerIsAdminOrIsSelf]

    def list(self, request, *args, **kwargs):
        user = request.user
        self.queryset = Category.objects.filter(owner=user).distinct()
        return viewsets.ModelViewSet.list(self, request, args, kwargs)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

    @action(detail=True, methods=['get'])
    def members(self, request, pk=None):
        user = request.user
        category = Category.objects.filter(id=pk, owner=user).last()
        if category:
            return Response(UserSerializer(category.members.all(),many=True).data, status=200)
        else:
            return Response([], status=404)


class UserFileViewSet(viewsets.ModelViewSet):
    serializer_class = UserFileSerialier
    queryset = UserFile.objects.all()
    permission_classes = [IsAuthenticated, OwnerIsAdminOrIsSelf]
    filter_backends = [DjangoFilterBackend, SearchFilter]
    search_fields = ['owner__full_name']
    filterset_fields = ['owner']


    def list(self, request, *args, **kwargs):
        user = request.user
        self.queryset = UserFile.objects\
                .filter(Q(owner=user) | Q(access_group__members=user) | Q(access_group=None))\
                .distinct()
        return viewsets.ModelViewSet.list(self, request, args, kwargs)


    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)
