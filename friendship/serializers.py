
from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from .models import FriendshipRequest



class UserSerializer(ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = ('pk', 'username', 'email')


class FriendshipRequestSerializer(ModelSerializer):
    sender = serializers.SerializerMethodField(read_only=True)
    photo = serializers.SerializerMethodField(read_only=True)

    def get_sender(self, obj):
        return obj.from_user.full_name

    def get_photo(self, obj):
        if 'request' in self.context:
            request = self.context['request']
            return request.build_absolute_uri(obj.from_user.photo.url)
        else:
            return ''
    class Meta:
        model = FriendshipRequest
        fields = "__all__"
        read_only_fields = ['from_user', 'created', 'rejected', 'viewed']

class FriendshipRequestActionSerializer(ModelSerializer):

    class Meta:
        fields = ('user_id', 'message')

class ContactsSerializer(serializers.Serializer):
    numbers = serializers.ListField(child=serializers.CharField(max_length=20))