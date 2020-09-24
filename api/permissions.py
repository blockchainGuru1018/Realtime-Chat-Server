from rest_framework.permissions import BasePermission

class IsAdminOrIsSelf(BasePermission):
    def has_object_permission(self, request, view, obj):

        user = request.user
        return obj == user or user.is_staff or user.is_superuser


class VoiceMessageIsAdminOrIsSelf(BasePermission):
    def has_object_permission(self, request, view, obj):


        user = request.user
        if obj.group:
            # print('permission', request.user.id, obj.group.creater.id, user.is_staff, user.is_superuser)
            is_members = True if request.user in obj.group.members.all() else False
            is_creator_group = True if request.user.id == obj.group.creater.id else False
            if not obj.id:
                return is_members or is_creator_group

        return obj.from_user == user or user.is_staff or user.is_superuser


class GroupIsAdminOrIsSelf(BasePermission):
    def has_object_permission(self, request, view, obj):
        user = request.user
        return obj.creater == user or user.is_staff or user.is_superuser


class OwnerIsAdminOrIsSelf(BasePermission):
    def has_object_permission(self, request, view, obj):
        user = request.user
        # print('OwnerIsAdminOrIsSelf', user.id, user.username, user.full_name)
        return obj.owner == user or user.is_staff or user.is_superuser
