from django.conf.urls import url
from django.urls import path, include
from rest_framework import routers
from push_notifications.api.rest_framework import APNSDeviceViewSet

from .views import (GenerateOTP,
                    ValidateOTP,
                    UserViewSet,
                    CallViewSet,
                    VoiceMessageViewSet,
                    SearchViewSet,
                    GroupViewSet,
                    GroupMessageViewSet,
                    EventViewSet,
                    TypeEventViewSet,
                    CategoryViewSet, UserFileViewSet)

router = routers.SimpleRouter()
router.register(r'users', UserViewSet)
router.register(r'call', CallViewSet)
router.register(r'voiceMessages', VoiceMessageViewSet)
router.register(r'groupMessages', GroupMessageViewSet)
router.register(r'apns_devices', APNSDeviceViewSet)
router.register(r'search', SearchViewSet)
router.register(r'groups', GroupViewSet)
router.register(r'events', EventViewSet)
router.register(r'event_types', TypeEventViewSet)
router.register(r'categories', CategoryViewSet)
router.register(r'user_files', UserFileViewSet)





urlpatterns = [
    url(r'^generateToken$', GenerateOTP.as_view(), name="generate"),
    url(r'^validateToken$', ValidateOTP.as_view(), name="validate"),
    path('', include('friendship.urls')),
]

urlpatterns += router.urls
