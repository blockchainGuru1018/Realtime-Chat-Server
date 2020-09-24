from __future__ import unicode_literals

import datetime
import hashlib
import os
import traceback
import logging
import re



from django.core.cache import cache
from WeaveChat import settings




from django.dispatch import receiver
from django.conf import settings
from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.contrib.gis.db.models import PointField
from django.contrib.gis.geos import Point
from django.db import models
from django.template.loader import render_to_string
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _
from phonenumber_field.modelfields import PhoneNumberField
from push_notifications.models import APNSDevice
from twilio.rest import Client
from WeaveChat.settings import (
    account_sid,
    auth_token,
    ERROR_TRACE_LEVEL
)
from recurrence.fields import RecurrenceField



AUTH_USER_MODEL = getattr(settings, "AUTH_USER_MODEL", "auth.User")


logger = logging.getLogger('log')
# account_sid = "ACc16935e5ba641a7fb530cb079d497f0d"
# auth_token = "2561601068d5704d56c85cfee004ba8f"
# account_sid = "AC6044163d21dfad50c05a42bd0146cd9f"
# auth_token = "5b4913deec9bdd1375a3770db40415a9"





class PhoneNumberUserManager(BaseUserManager):
    use_in_migrations = True

    def _create_user(self, username, phone_number, email,
                     password, **extra_fields):
        """
        Creates and saves a User with the given username, email and password.
        """
        if not username:
            raise ValueError('The given username must be set')
        email = self.normalize_email(email)
        username = self.model.normalize_username(username)
        user = self.model(
            username=username, email=email, phone_number=phone_number.__str__(),
            **extra_fields
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, username, phone_number,
                    email=None, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(username, phone_number, email, password,
                                 **extra_fields)

    def create_superuser(self, username, phone_number, email, password,
                         **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(username, phone_number, email, password,
                                 **extra_fields)


class PhoneNumberAbstactUser(AbstractUser):
    phone_number = PhoneNumberField(unique=True)
    full_name=models.CharField(max_length=60, default='')
    objects = PhoneNumberUserManager()

    class Meta:
        verbose_name = _('user')
        verbose_name_plural = _('users')
        abstract = True

class CustomUser(PhoneNumberAbstactUser):
    REQUIRED_FIELDS = ['phone_number', 'email']
    dob=models.DateField(default=None, null=True)
    bio=models.TextField(default='', blank=True)
    address=models.CharField(max_length=120, default='')
    location=PointField(default=Point(0,0))
    is_location=models.BooleanField(default=False)
    photo=models.FileField(null=True)
    is_blocked = models.BooleanField(default=False)
    black_list = models.ManyToManyField('self', symmetrical=False, blank = True)

    def __str__(self):
        return self.username

    def __unicode__(self):
        return self.username


    @property
    def last_seen(self):
        return cache.get('seen_%s' % self.username)

    @property
    def online(self):
        if self.last_seen:
            now = datetime.datetime.now()
            if now > self.last_seen + datetime.timedelta(
                         seconds=settings.USER_ONLINE_TIMEOUT):
                return False
            else:
                return True
        else:
            return False


class Category(models.Model):
    owner = models.ForeignKey(AUTH_USER_MODEL, models.CASCADE,
                        related_name="categories",  blank = True)
    name = models.CharField(max_length=100)
    description = models.TextField(null=True, blank = True)
    members = models.ManyToManyField(AUTH_USER_MODEL, blank=True)



class UserFile(models.Model):
    owner = models.ForeignKey(AUTH_USER_MODEL, models.CASCADE,
                        related_name="files", blank = True)
    file = models.FileField(null=True, blank = True)
    access_group = models.ManyToManyField(Category, blank=True)



def delete_files(file_model_list):
    for file in file_model_list:
        if file:
            if os.path.isfile(file.path):
                os.remove(file.path)

@receiver(models.signals.post_delete, sender=UserFile)
def user_file_delete(sender, instance, **kwargs):
    delete_files([instance.file])
    # files = [instance.file]
    # for file in files:
    #     if file:
    #         if os.path.isfile(file.path):
    #             os.remove(file.path)



class PhoneToken(models.Model):
    phone_number = PhoneNumberField(editable=False)
    otp = models.CharField(max_length=40, editable=False)
    timestamp = models.DateTimeField(auto_now_add=True, editable=False)
    attempts = models.IntegerField(default=0)
    used = models.BooleanField(default=False)

    class Meta:
        verbose_name = "OTP Token"
        verbose_name_plural = "OTP Tokens"

    def __str__(self):
        return "{} - {}".format(self.phone_number, self.otp)

    @classmethod
    def create_otp_for_number(cls, number):
        # The max otps generated for a number in a day are only 10.
        # Any more than 10 attempts returns False for the day.
        today_min = datetime.datetime.combine(datetime.date.today(), datetime.time.min)
        today_max = datetime.datetime.combine(datetime.date.today(), datetime.time.max)
        otps = cls.objects.filter(phone_number=number, timestamp__range=(today_min, today_max))
        if otps.count() <= getattr(settings, 'PHONE_LOGIN_ATTEMPTS', 10):
            otp = cls.generate_otp(length=getattr(settings, 'PHONE_LOGIN_OTP_LENGTH', 4))
            phone_token = PhoneToken(phone_number=number, otp=otp)
            phone_token.save()
            from_phone = getattr(settings, 'SENDSMS_FROM_NUMBER')
            client = Client(account_sid, auth_token)
            message = client.messages.create(
                to=number,
                from_=from_phone,
                body="Your Weave app verification code is: \r\n " + otp,
            )
            return phone_token
        else:
            return False

    @classmethod
    def generate_otp(cls, length=4):
        hash_algorithm = getattr(settings, 'PHONE_LOGIN_OTP_HASH_ALGORITHM', 'sha256')
        m = getattr(hashlib, hash_algorithm)()
        m.update(getattr(settings, 'SECRET_KEY', None).encode('utf-8'))
        m.update(os.urandom(16))
        otp = str(int(m.hexdigest(), 16))[-length:]
        return otp







class Group(models.Model):
    creater = models.ForeignKey(AUTH_USER_MODEL, models.SET_NULL,
                        related_name="group_creator", null=True, blank=True)
    name = models.CharField(max_length=100)
    description = models.TextField(null=True)
    photo = models.FileField(null=True)
    access_key = models.CharField(max_length=100, null=True, blank=True)
    general_access = models.BooleanField(default=True)
    members = models.ManyToManyField(AUTH_USER_MODEL, related_name="member_group", blank=True)

    def save(self, *args, **kwargs):
        # print('kwargs', kwargs)
        if not self.id:
            str_date = str(datetime.datetime.now())
            self.access_key = hashlib.sha256(str_date.encode('utf-8')).hexdigest()
        super(Group, self).save(*args, **kwargs)



EXTRA_TYPE = [
    ('video','video'),
    ('image', 'image'),
    ('doc', 'doc')
]

class VoiceMessage(models.Model):
    to_user = models.ForeignKey(AUTH_USER_MODEL, models.CASCADE, related_name="receiver", null=True, blank=True)
    from_user = models.ForeignKey(
        AUTH_USER_MODEL, models.CASCADE, related_name="sender"
    )
    created = models.DateTimeField(default=timezone.now)
    file=models.FileField(null=True, blank=True)
    # viewed = models.BooleanField(default=False)
    is_heard = models.BooleanField(default=False)
    is_seen = models.BooleanField(default=False)
    text=models.TextField(null=True)
    extra_file = models.FileField(null=True, blank=True)
    extra_type = models.CharField(max_length=10, choices=EXTRA_TYPE, null=True)
    group = models.ForeignKey(Group, models.CASCADE,
                            related_name="messages", null=True, blank=True)


    def get_type(self):
        key_type = 'empty'
        if self.text:
            key_type = 'text'
        if self.file:
            key_type = 'voice'
        elif self.extra_file:
            key_type = self.extra_type

        return key_type


    def announce(self):
        present_name = {
            'voice': 'Voice Message',
            'text': 'Text Message',
            'video': 'Video',
            'image': 'Image',
        }

        return "New %s "% present_name.get(self.get_type(), 'Message')



class CallInfo(models.Model):
    to_user = models.ForeignKey(AUTH_USER_MODEL, models.CASCADE, related_name="call_receiver")
    from_user = models.ForeignKey(
        AUTH_USER_MODEL, models.CASCADE, related_name="call_sender"
    )
    created = models.DateTimeField(default=timezone.now)
    status = models.CharField(max_length=60, default='')
    duration = models.IntegerField(default=0)

class LikeMessage(models.Model):
    message = models.ForeignKey(VoiceMessage, models.CASCADE, related_name="likes")
    user = models.ForeignKey(AUTH_USER_MODEL, models.CASCADE, related_name="likes")
    updated = models.DateTimeField(auto_now=True)
    is_like = models.BooleanField(default=True)



@receiver(models.signals.post_delete, sender=VoiceMessage)
def voice_message_delete_file_on_delete(sender, instance, **kwargs):
    delete_files([instance.file, instance.extra_file])
    # files = [instance.file, instance.extra_file]
    # for file in files:
    #     if file:
    #         if os.path.isfile(file.path):
    #             os.remove(file.path)



def send_to_APNSDevices(voice_message):
    try:
        users = []
        if voice_message.to_user:
            users.append(voice_message.to_user)
        elif voice_message.group:
            users = voice_message.group.members.all()

        announce = voice_message.announce()
        type_ = voice_message.get_type()
        for user in users:
            device = APNSDevice.objects.filter(user=user).last()
            device.send_message(announce, extra={"type": type_})
            logger.info(f'send_to_APNSDevices {user} {announce} {type_}')
    except Exception as e:
        logger.error(traceback.format_exc(ERROR_TRACE_LEVEL))


class TypeEvent(models.Model):
    name = models.CharField(max_length=100)

class Event(models.Model):
    creator = models.ForeignKey(AUTH_USER_MODEL, models.CASCADE, null=True,)
    title = models.CharField(max_length=200, blank=True, null=True)
    created = models.DateTimeField(blank=True, auto_now_add=True, null=True)
    start_date = models.DateField(blank=True, null=True)
    # end_date = models.DateField(blank=True, null=True)
    start_time = models.TimeField(null=True, blank=True)
    end_time = models.TimeField(null=True, blank=True)
    place = models.CharField(max_length=250, null=True, blank=True)
    type = models.ForeignKey(TypeEvent, on_delete=models.SET_NULL, null=True, blank=True)
    description = models.CharField(max_length=250,  null=True, blank=True)
    party = models.ManyToManyField(AUTH_USER_MODEL, blank = True, related_name="member_events")
    room = models.ForeignKey(Group, on_delete=models.SET_NULL, null=True, blank=True)
    recurrences = RecurrenceField()

    def __str__(self):
        return f"id:{self.id} {self.start_date} {self.title}"

    def save(self, *args, **kwargs):
        if not self.start_date:
            self.start_date = datetime.datetime.now().date()

        super(Event, self).save(*args, **kwargs)


@receiver(models.signals.post_save, sender=Event)
def post_saved_event(sender, instance, **kwargs):
    if instance.recurrences:
        instance.dates.all().delete()
        d = datetime.datetime.combine(instance.start_date, datetime.datetime.now().time())
        for date in set(list(instance.recurrences.occurrences(dtstart=d))):
            EventDate(event=instance,date=date).save()

class EventDate(models.Model):
    event = models.ForeignKey(Event, models.CASCADE, related_name="dates")
    date = models.DateField()

    def __str__(self):
        return f"id:{self.id} {self.date}"
