from django.apps import apps
from django.contrib.auth import get_user_model
from django.http import HttpResponse
from django.shortcuts import get_object_or_404

from rest_framework import status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .models import Friend, FriendshipRequest
from .serializers import FriendshipRequestSerializer, FriendshipRequestActionSerializer, ContactsSerializer
from .exceptions import AlreadyFriendsError, AlreadyExistsError

from api.permissions import IsAdminOrIsSelf

config = apps.get_app_config('friendship')


class FriendViewSet(viewsets.ModelViewSet):
    """
    ViewSet for Friend model
    """
    permission_classes = config.permission_classes
    serializer_class = config.user_serializer
    queryset = Friend.objects.all()

    @action(detail=False, methods=['post'])
    def insert(self, request):
        contacts = ContactsSerializer(data=request.data)
        if not contacts.is_valid():
            return Response({"numbers": ['Check the value again']}, status=400)
        numbers = contacts.validated_data['numbers']
        for number in numbers:
            try :
                user = get_user_model().objects.get(phone_number=number)
                friend_obj = Friend.objects.add_friend(
                    request.user,
                    user,
                    message=''
                )
                friend_obj.accept()
            except:
                pass
        self.permission_classes = [IsAuthenticated, IsAdminOrIsSelf]
        friends = Friend.objects.friends(request.user)
        self.queryset = friends
        return viewsets.ModelViewSet.list(self, request)

    def destroy(self, request, pk=None):
        """
        Deletes a friend relationship
        The user id specified in the URL will be removed from the current user's friends
        """

        user_friend = get_object_or_404(get_user_model(), pk=pk)

        if Friend.objects.remove_friend(request.user, user_friend):
            message = 'deleted'
            status_code = status.HTTP_204_NO_CONTENT
        else:
            message = 'not deleted'
            status_code = status.HTTP_304_NOT_MODIFIED

        return Response(
            {"message": message},
            status=status_code
        )


class FriendshipRequestViewSet(viewsets.ModelViewSet):
    """
    ViewSet for FriendshipRequest model
    """
    permission_classes = [IsAuthenticated, IsAdminOrIsSelf]
    serializer_class = FriendshipRequestSerializer
    queryset = FriendshipRequest.objects.select_related("from_user", "to_user")

    def create(self, request):
        """
        Creates a friend request
        POST data:
        - user_id
        - message
        """
        try :
            friend_obj = Friend.objects.add_friend(
                request.user,                                                     # The sender
                get_object_or_404(get_user_model(), pk=request.data['to_user']),  # The recipient
                message=request.data.get('message', '')
            )
        except AlreadyFriendsError as e:
            return HttpResponse(
                str(e),
                status=409
            )
        except AlreadyExistsError as e:
            return HttpResponse(
                str(e),
                status=409
            )
        return Response(
            FriendshipRequestSerializer(friend_obj).data,
            status.HTTP_201_CREATED
        )

    @action(detail=False)
    def requests(self, request):
        self.queryset = self.queryset.filter(to_user=request.user, rejected__isnull=True).all()
        return viewsets.ModelViewSet.list(self, request)

    @action(detail=False)
    def sent_requests(self, request):
        self.queryset = self.queryset.filter(from_user=request.user).all()
        return viewsets.ModelViewSet.list(self, request)

    @action(detail=False)
    def rejected_requests(self, request):
        self.queryset = self.queryset.filter(to_user=request.user, rejected__isnull=False).all()
        return viewsets.ModelViewSet.list(self, request)

    @action(detail=True, methods=['post'])
    def accept(self, request, pk=None):
        friendship_request = get_object_or_404(FriendshipRequest, pk=pk, to_user=request.user)
        friendship_request.accept()
        return Response(FriendshipRequestSerializer(friendship_request).data)

    @action(detail=True, methods=['post', 'get'])
    def reject(self, request, pk=None):
        friendship_request = get_object_or_404(FriendshipRequest, pk=pk, to_user=request.user)
        friendship_request.reject()
        return Response(FriendshipRequestSerializer(friendship_request).data)

