from channels.routing import ProtocolTypeRouter, URLRouter
from django.conf.urls import url
from . import consumers
from .auth import TokenAuthMiddlewareStack

websocket_urlpatterns = [
    url(r'^ws/chat/(?P<room_name>\w+)/$', consumers.ChatConsumer),
]

application = ProtocolTypeRouter({
    'websocket': TokenAuthMiddlewareStack(
        URLRouter(
            websocket_urlpatterns
        )
    ),
})
