import base64
import json, bson
import uuid
import traceback
import logging
import re

from asgiref.sync import async_to_sync
from channels.generic.websocket import WebsocketConsumer

from django.contrib.auth import get_user_model
from django.core.files.base import ContentFile
from django.shortcuts import get_object_or_404

from push_notifications.models import APNSDevice

from api.models import VoiceMessage, Group, send_to_APNSDevices
from api.serializers import VoiceMessageSerializer
from django.db.models import Q
from friendship.models import FriendshipRequest
from friendship.serializers import FriendshipRequestSerializer

from WeaveChat.settings  import ERROR_TRACE_LEVEL

User = get_user_model()

logger = logging.getLogger('log')

class ChatConsumer(WebsocketConsumer):

    # def new_message(self, data):
    #     from_user = self.scope['user']
    #     for id in self.room_group_name.split('_'):
    #         if int(id) != from_user.pk:
    #             to_user = User.objects.get(pk=id)
    #             break
    #     file = ContentFile(data)
    #     file.name = "%s.%s" % (uuid.uuid4(), 'm4a')
    #     msg = VoiceMessage.objects.create(from_user=from_user, to_user=to_user, file=file)
    #     content = {
    #         'command': 'new_message',
    #         'message': VoiceMessageSerializer(msg).data
    #     }
    #     self.send_chat_message(content)
    #
    #     try:
    #         device = APNSDevice.objects.filter(user=msg.to_user).last()
    #         device.send_message("New Voice Message", extra={"type": "voice"})
    #     except:
    #         pass

    def add_file(self, binary_data, format):
        # binary_data = binary_data.encode()
        file = ContentFile(binary_data)
        file.name = "%s.%s" % (uuid.uuid4(), format)
        return file


    def create_message(self, data):
        from_user = self.scope['user']
        to_user_id = data.get('to_user')
        group = None
        if not to_user_id:
            if re.findall('group',self.room_group_name):
                group_id = self.room_group_name.split('_')[1]
                group_objs = Group.objects.filter(id=int(group_id))
                if group_objs.filter(Q(creater=from_user) | Q(members=from_user)).distinct():
                    group = group_objs.first()
                else:
                    raise Exception('No access to this group')
            else:
                for id in self.room_group_name.split('_'):
                    if int(id) != from_user.pk:
                        to_user_id = id
                        break

        param = {'from_user': from_user}

        if to_user_id:
            param['to_user'] = User.objects.get(pk=to_user_id)


        if group:
            param['group'] = group

        if 'text' in data:
            param['text'] = data.get('text')


        if 'voice_data' in data:
            param['file'] = self.add_file(data['voice_data'], 'm4a')

        if 'extra' in data:
            param['extra_file'] = self.add_file(data['extra']['data'],
                                                    data['extra']['format'])
            param['extra_type'] = data['extra']['type']

        return VoiceMessage.objects.create(**param)



    def new_message(self, data):
        try:
            msg = None
            if 'message_id' in data:
                msg = VoiceMessage.objects.filter(pk=data.get('message_id')).first()
            else:
                msg = self.create_message(data)

            if msg:

                # key_type = self.identify_type(msg)

                content = {
                    'command': 'new_message',
                    'message': VoiceMessageSerializer(msg).data
                }
                self.send_chat_message(content)
                send_to_APNSDevices(msg)

                    # device = APNSDevice.objects.filter(user=msg.to_user).last()
                    # name_message = "New %s "% self.type_message.get(key_type, 'Message')
                    # # print('name_message', name_message)
                    # device.send_message(name_message, extra={"type": key_type})
            else:
                logger.error('Failed to create message')

        except Exception as e:
            logger.error(traceback.format_exc(ERROR_TRACE_LEVEL))



    def friend_request(self, data):
        request = get_object_or_404(FriendshipRequest, pk=data['id'])
        content = {
            'command': 'friend_request',
            'request': FriendshipRequestSerializer(request).data
        }
        self.send_chat_message(content)

    def friend_accept(self, data):
        content = {
            'command': 'friend_accept',
        }
        self.send_chat_message(content)

    def message_viewed(self, data):
        '''flags = ['is_heard', 'is_seen']'''
        flags = data.get('flags')
        message_ids = data.get('message_ids')
        if message_ids and flags:
            try:
                param = {}
                for flag in data.get('flags'):
                    param[flag] = True
                mass_list = VoiceMessage.objects.filter(pk__in=message_ids)
                mass_list.update(**param)

                self.send_chat_message(data)
            except Exception as e:
                self.send_chat_message({'command':'message_viewed',
                                        'data': data,
                                        'error': e})

    def message_creation(self, date):
        '''date = {
            'typing' : 'start' or 'stop' ,
            'recording' : 'start' or 'stop' ,
        }'''
        user = self.scope['user']
        date['user_id'] = user.pk
        self.send_chat_message(date)


    def delete_message(self, data):
        message_ids = data.get('message_ids')
        if message_ids:
            mass_list = VoiceMessage.objects.filter(pk__in=message_ids)
            mass_list.delete()

        self.send_chat_message(data)

    def status(self, data):
        self.send_chat_message(data)


    def connect(self):
        self.room_name = self.scope['url_route']['kwargs']['room_name']
        self.room_group_name = self.room_name

        # Join room group
        async_to_sync(self.channel_layer.group_add)(
            self.room_group_name,
            self.channel_name
        )
        if isinstance(self.scope['user'], User):
            self.accept()

    def disconnect(self, close_code):
        # leave group room
        async_to_sync(self.channel_layer.group_discard)(
            self.room_group_name,
            self.channel_name
        )

    def receive(self, text_data = None, bytes_data = None):
        # if text_data is not None:
        #     data = json.loads(text_data)
        #     self.commands[data['command']](self, data)
        # if bytes_data is not None:
        #     self.new_message(bytes_data)
# -----------------------------------------------------------------
        data = None
        try:
            if text_data is not None:
                data = json.loads(text_data)
            elif bytes_data is not None:
                data = bson.loads(bytes_data)
        except Exception as e:
            logger.error(traceback.format_exc(ERROR_TRACE_LEVEL))

        # this command is needed for backward compatibility with the old protocol
        # data = {
        #     'command': 'new_message',
        #     'voice_data': bytes_data
        # }

        if data:
            self.router(data)

        else:
            logger.error('Unknown data type. Message not received')



    commands = {
        'friend_accept': friend_accept,
        'friend_request': friend_request,
        'message_viewed': message_viewed,
        'message_creation': message_creation,
        'new_message': new_message,
        'delete_message': delete_message,
        'status': status

    }

    def router(self, data):
        self.commands[data['command']](self, data)




    def send_message(self, message):
        self.send(text_data=message)

    def send_chat_message(self, message):
        # Send message to room group
        async_to_sync(self.channel_layer.group_send)(
            self.room_group_name,
            {
                'type': 'chat_message',
                'message': message
            }
        )

    # Receive message from room group
    def chat_message(self, event):
        message = event['message']
        # Send message to WebSocket
        self.send(text_data=json.dumps(message))
