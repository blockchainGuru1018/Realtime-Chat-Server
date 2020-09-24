from django.conf.urls import url
from rest_framework import routers

from .views import FriendViewSet, FriendshipRequestViewSet

router = routers.SimpleRouter()
router.register(r'friends', FriendshipRequestViewSet, basename='friendrequests')
router.register(r'friend', FriendViewSet, basename='friendrequests')

# router.register(r'friends', FriendViewSet, basename='friends')

urlpatterns = router.urls