from django.contrib import admin
from .models import Friend, FriendshipRequest


admin.site.register(Friend)
admin.site.register(FriendshipRequest)

# Register your models here.
