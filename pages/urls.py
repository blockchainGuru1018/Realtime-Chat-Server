from . import views
from django.urls import include, path
from .views import support, index, privacy, thank_you

urlpatterns = [
    path('privacy', privacy),
    path('', index),
    path('support/', support, name='support'),
    path('thanks/', thank_you)
]
