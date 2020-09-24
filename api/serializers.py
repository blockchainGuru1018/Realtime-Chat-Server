from django.contrib.auth import get_user_model
from phonenumber_field.formfields import PhoneNumberField
from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from tinytag import TinyTag
import traceback
import logging
from datetime import datetime
from push_notifications.models import APNSDevice
from .models import (PhoneToken, VoiceMessage, LikeMessage,
                    CallInfo, Group, Event, TypeEvent, EventDate, Category, UserFile)
from WeaveChat.settings import ERROR_TRACE_LEVEL

User = get_user_model()
logger = logging.getLogger('log')








class PhoneTokenCreateSerializer(ModelSerializer):
    phone_number = serializers.CharField(validators=PhoneNumberField().validators)

    class Meta:
        model = PhoneToken
        fields = ('pk', 'phone_number')


class PhoneTokenValidateSerializer(ModelSerializer):
    pk = serializers.IntegerField()
    otp = serializers.CharField(max_length=40)

    class Meta:
        model = PhoneToken
        fields = ('pk', 'otp')


class CallInfoSerializer(ModelSerializer):
    created = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S", read_only=True)
    sender = serializers.SerializerMethodField(read_only=True)

    def get_sender(self, obj):
        user = self.context['request'].user
        if obj.from_user == user:
            return obj.to_user.full_name
        else:
            return obj.from_user.full_name

    class Meta:
        model = CallInfo
        fields = "__all__"
        read_only_fields = ['created', 'from_user']

class VoiceMessageSerializer(ModelSerializer):
    duration = serializers.SerializerMethodField(read_only=True)
    is_like = serializers.SerializerMethodField(read_only=True)
    created = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S", read_only=True)
    sender = serializers.SerializerMethodField(read_only=True)
    photo = serializers.SerializerMethodField(read_only=True)
    count_likes = serializers.SerializerMethodField(read_only=True)

    # file = serializers.FileField(allow_empty_file = True , allow_null = True , required = False)
    # extra_file = serializers.FileField(allow_empty_file = True , allow_null = True , required = False)
    #

    def get_count_likes(self, obj):
        if 'request' in self.context:
            user = self.context['request'].user

            likes = LikeMessage.objects.all().filter(user__exact=obj.from_user, message=obj)

            return len(likes)
        else:
            return 0


    def get_duration(self, obj):
        out = 0
        try:
            if obj.file:
                if obj.file.path:
                    tag = TinyTag.get(obj.file.path, duration=True)
                    if tag.duration:
                        out = int(tag.duration)
        except Exception as e:
             logger.error(traceback.format_exc(ERROR_TRACE_LEVEL))
        return out

    def get_is_like(self, obj):
        if 'request' in self.context:
            user = self.context['request'].user
            likes = []
            # if obj.to_user == user:
            #     likes = LikeMessage.objects.all().filter(user=user, message=obj)
            # if obj.from_user == user:
                # likes = LikeMessage.objects.all().filter(user=obj.to_user, message=obj)

            likes = LikeMessage.objects.all().filter(user__exact=obj.from_user, message=obj)

            if len(likes) == 0:
                return False
            return likes[0].is_like
        else:
            return False

    def get_sender(self, obj):
        if 'request' in self.context and obj.to_user:
            user = self.context['request'].user
            if obj.from_user == user:
                return obj.to_user.full_name
            else:
                return obj.from_user.full_name
        else:
            return obj.from_user.full_name

    def get_photo(self, obj):
        if 'request' in self.context:
            request = self.context['request']
            user = request.user
            if obj.from_user == user and obj.to_user:
                return request.build_absolute_uri(obj.to_user.photo.url)
            else:
                return request.build_absolute_uri(obj.from_user.photo.url)
        else:
            return ''

    class Meta:
        model = VoiceMessage
        fields = "__all__"
        read_only_fields = ['created', 'from_user']


class LikeMessageSerializer(ModelSerializer):
    message = VoiceMessageSerializer()
    updated = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S", read_only=True)

    class Meta:
        model = LikeMessage
        fields = "__all__"
        read_only_fields = ['created', 'user']


class UserSerializer(ModelSerializer):

    class Meta:
        model = User
        fields = ['id', 'full_name', 'phone_number',
                            'location', 'is_location', 'is_blocked', 'photo',
                            'dob', 'bio', 'address', 'black_list', 'last_seen', 'online']
        read_only_fields = ['phone_number']


class UserLikesSerializer(ModelSerializer):
    likes = LikeMessageSerializer(many=True)

    class Meta:
        model = User
        fields = ['id', 'likes']


class APNSDeviceSerialier(ModelSerializer):

    class Meta:
        model = APNSDevice
        fields = "__all__"



class GroupSerialier(ModelSerializer):

    class Meta:
        model = Group
        fields = "__all__"


class TypeEventSerialier(ModelSerializer):

    class Meta:
        model = TypeEvent
        fields = "__all__"



class EventSerializer(ModelSerializer):
    type_name = serializers.SerializerMethodField(read_only=True)
    class Meta:
        model = Event
        fields = "__all__"
    def get_type_name(self, obj):
        if obj.type:
            return obj.type.name



class EventDateSerializer(ModelSerializer):
    event = serializers.SerializerMethodField(read_only=True)
    class Meta:
        model = EventDate
        fields = "__all__"

    def get_event(self, obj):
        return EventSerializer(obj.event).data

class CategorySerialier(ModelSerializer):

    class Meta:
        model = Category
        fields = "__all__"

class UserFileSerialier(ModelSerializer):

    class Meta:
        model = UserFile
        fields = "__all__"
