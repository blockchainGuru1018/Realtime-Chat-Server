from django.contrib import admin
from api.models import (PhoneToken, CustomUser,
                        VoiceMessage, LikeMessage,
                        CallInfo, Event)

admin.site.register(PhoneToken)
admin.site.register(CustomUser)
admin.site.register(VoiceMessage)
admin.site.register(CallInfo)
admin.site.register(LikeMessage)
admin.site.register(Event)

# Register your models here.

# class GroupUser(admin.ModelAdmin):
#     def save_model(self, request, obj, form, change):
#         print('----------- GroupUser')
#         # if not obj.id:
#         obj.creater = request.user
#         obj.save()
# admin.site.register(GroupMessage, GroupUser);
