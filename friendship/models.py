from django.conf import settings
from django.core.cache import cache
from django.db import models
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _
from .signals import (
    friendship_request_created,
    friendship_request_rejected,
    friendship_request_canceled,
    friendship_request_viewed,
    friendship_request_accepted,
    friendship_removed,
    follower_created,
    follower_removed,
    followee_created,
    followee_removed,
    following_created,
    following_removed,
    block_created,
    block_removed,
)
from .exceptions import AlreadyFriendsError, AlreadyExistsError
# Create your models here.

AUTH_USER_MODEL = getattr(settings, "AUTH_USER_MODEL", "auth.User")

CACHE_TYPES = {
    "friends": "f-%s",
    "followers": "fo-%s",
    "following": "fl-%s",
    "blocks": "b-%s",
    "blocked": "bo-%s",
    "blocking": "bd-%s",
    "requests": "fr-%s",
    "sent_requests": "sfr-%s",
    "unread_requests": "fru-%s",
    "unread_request_count": "fruc-%s",
    "read_requests": "frr-%s",
    "rejected_requests": "frj-%s",
    "unrejected_requests": "frur-%s",
    "unrejected_request_count": "frurc-%s",
}

BUST_CACHES = {
    "friends": ["friends"],
    "followers": ["followers"],
    "blocks": ["blocks"],
    "blocked": ["blocked"],
    "following": ["following"],
    "blocking": ["blocking"],
    "requests": [
        "requests",
        "unread_requests",
        "unread_request_count",
        "read_requests",
        "rejected_requests",
        "unrejected_requests",
        "unrejected_request_count",
    ],
    "sent_requests": ["sent_requests"],
}

def cache_key(type, user_pk):
    """
    Build the cache key for a particular type of cached value
    """
    return CACHE_TYPES[type] % user_pk

def bust_cache(type, user_pk):
    """
    Bust our cache for a given type, can bust multiple caches
    """
    bust_keys = BUST_CACHES[type]
    keys = [CACHE_TYPES[k] % user_pk for k in bust_keys]
    cache.delete_many(keys)

class FriendshipManager(models.Manager):
    """ Friendship manager """

    def friends(self, user):
        """ Return a list of all friends """
        key = cache_key("friends", user.pk)
        friends = cache.get(key)

        if friends is None:
            qs = (
                Friend.objects.select_related("from_user", "to_user")
                .filter(to_user=user)
                .all()
            )
            friends = [u.from_user for u in qs]
        # cache.set(key, friends)

        return friends

    def requests(self, user):
        """ Return a list of friendship requests """
        key = cache_key("requests", user.pk)
        requests = cache.get(key)

        if requests is None:
            qs = (
                FriendshipRequest.objects.select_related("from_user", "to_user")
                .filter(to_user=user)
                .all()
            )
            requests = list(qs)
            cache.set(key, requests)

        return requests

    def sent_requests(self, user):
        """ Return a list of friendship requests from user """
        key = cache_key("sent_requests", user.pk)
        requests = cache.get(key)

        if requests is None:
            qs = (
                FriendshipRequest.objects.select_related("from_user", "to_user")
                .filter(from_user=user)
                .all()
            )
            requests = list(qs)
            cache.set(key, requests)

        return requests

    # def unread_requests(self, user):
    #     """ Return a list of unread friendship requests """
    #     key = cache_key("unread_requests", user.pk)
    #     unread_requests = cache.get(key)

    #     if unread_requests is None:
    #         qs = (
    #             FriendshipRequest.objects.select_related("from_user", "to_user")
    #             .filter(to_user=user, viewed__isnull=True)
    #             .all()
    #         )
    #         unread_requests = list(qs)
    #         cache.set(key, unread_requests)

    #     return unread_requests

    # def unread_request_count(self, user):
    #     """ Return a count of unread friendship requests """
    #     key = cache_key("unread_request_count", user.pk)
    #     count = cache.get(key)

    #     if count is None:
    #         count = (
    #             FriendshipRequest.objects.select_related("from_user", "to_user")
    #             .filter(to_user=user, viewed__isnull=True)
    #             .count()
    #         )
    #         cache.set(key, count)

    #     return count

    # def read_requests(self, user):
    #     """ Return a list of read friendship requests """
    #     key = cache_key("read_requests", user.pk)
    #     read_requests = cache.get(key)

    #     if read_requests is None:
    #         qs = (
    #             FriendshipRequest.objects.select_related("from_user", "to_user")
    #             .filter(to_user=user, viewed__isnull=False)
    #             .all()
    #         )
    #         read_requests = list(qs)
    #         cache.set(key, read_requests)

    #     return read_requests

    # def rejected_requests(self, user):
    #     """ Return a list of rejected friendship requests """
    #     key = cache_key("rejected_requests", user.pk)
    #     rejected_requests = cache.get(key)

    #     if rejected_requests is None:
    #         qs = (
    #             FriendshipRequest.objects.select_related("from_user", "to_user")
    #             .filter(to_user=user, rejected__isnull=False)
    #             .all()
    #         )
    #         rejected_requests = list(qs)
    #         cache.set(key, rejected_requests)

    #     return rejected_requests

    # def unrejected_requests(self, user):
    #     """ All requests that haven't been rejected """
    #     key = cache_key("unrejected_requests", user.pk)
    #     unrejected_requests = cache.get(key)

    #     if unrejected_requests is None:
    #         qs = (
    #             FriendshipRequest.objects.select_related("from_user", "to_user")
    #             .filter(to_user=user, rejected__isnull=True)
    #             .all()
    #         )
    #         unrejected_requests = list(qs)
    #         cache.set(key, unrejected_requests)

    #     return unrejected_requests

    # def unrejected_request_count(self, user):
    #     """ Return a count of unrejected friendship requests """
    #     key = cache_key("unrejected_request_count", user.pk)
    #     count = cache.get(key)

    #     if count is None:
    #         count = (
    #             FriendshipRequest.objects.select_related("from_user", "to_user")
    #             .filter(to_user=user, rejected__isnull=True)
    #             .count()
    #         )
    #         cache.set(key, count)

    #     return count

    def add_friend(self, from_user, to_user, message=None):
        """ Create a friendship request """
        if from_user == to_user:
            raise ValidationError("Users cannot be friends with themselves")

        if self.are_friends(from_user, to_user):
            raise AlreadyFriendsError("Users are already friends")

        if self.can_request_send(from_user, to_user):
            raise AlreadyExistsError("Friendship already requested")

        if message is None:
            message = ""

        request, created = FriendshipRequest.objects.get_or_create(
            from_user=from_user, to_user=to_user
        )

        if created is False:
            raise AlreadyExistsError("Friendship already requested")

        if message:
            request.message = message
            request.save()

        bust_cache("requests", to_user.pk)
        bust_cache("sent_requests", from_user.pk)
        friendship_request_created.send(sender=request)

        return request

    def can_request_send(self, from_user, to_user):
        """ Checks if a request was sent """
        if from_user == to_user:
            return False

        if not FriendshipRequest.objects.filter(
            from_user=from_user, to_user=to_user
        ).exists():
            return False

        return True

    def remove_friend(self, from_user, to_user):
        """ Destroy a friendship relationship """
        try:
            qs = (
                Friend.objects.filter(
                    Q(to_user=to_user, from_user=from_user)
                    | Q(to_user=from_user, from_user=to_user)
                )
                .distinct()
                .all()
            )

            if qs:
                friendship_removed.send(
                    sender=qs[0], from_user=from_user, to_user=to_user
                )
                qs.delete()
                # bust_cache("friends", to_user.pk)
                # bust_cache("friends", from_user.pk)
                return True
            else:
                return False
        except Friend.DoesNotExist:
            return False

    def are_friends(self, user1, user2):
        """ Are these two users friends? """
        friends1 = cache.get(cache_key("friends", user1.pk))
        friends2 = cache.get(cache_key("friends", user2.pk))
        if friends1 and user2 in friends1:
            return True
        elif friends2 and user1 in friends2:
            return True
        else:
            try:
                Friend.objects.get(to_user=user1, from_user=user2)
                return True
            except Friend.DoesNotExist:
                return False


class FriendshipRequest(models.Model):
    """ Model to represent friendship requests """

    from_user = models.ForeignKey(
        AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="friendship_requests_sent",
    )
    to_user = models.ForeignKey(
        AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="friendship_requests_received",
    )

    message = models.TextField(_("Message"), blank=True)

    created = models.DateTimeField(default=timezone.now)
    rejected = models.DateTimeField(blank=True, null=True)
    viewed = models.DateTimeField(blank=True, null=True)

    class Meta:
        verbose_name = _("Friendship Request")
        verbose_name_plural = _("Friendship Requests")
        unique_together = ("from_user", "to_user")

    def __str__(self):
        return "%s" % self.from_user_id

    def accept(self):
        """ Accept this friendship request """
        relation1 = Friend.objects.create(
            from_user=self.from_user, to_user=self.to_user
        )

        relation2 = Friend.objects.create(
            from_user=self.to_user, to_user=self.from_user
        )

        friendship_request_accepted.send(
            sender=self, from_user=self.from_user, to_user=self.to_user
        )

        self.delete()

        # Delete any reverse requests
        FriendshipRequest.objects.filter(
            from_user=self.to_user, to_user=self.from_user
        ).delete()

        # Bust requests cache - request is deleted
        bust_cache("requests", self.to_user.pk)
        bust_cache("sent_requests", self.from_user.pk)
        # Bust reverse requests cache - reverse request might be deleted
        bust_cache("requests", self.from_user.pk)
        bust_cache("sent_requests", self.to_user.pk)
        # Bust friends cache - new friends added
        # bust_cache("friends", self.to_user.pk)
        # bust_cache("friends", self.from_user.pk)

        return True

    def reject(self):
        """ reject this friendship request """
        self.rejected = timezone.now()
        self.save()
        friendship_request_rejected.send(sender=self)
        bust_cache("requests", self.to_user.pk)

    def cancel(self):
        """ cancel this friendship request """
        self.delete()
        friendship_request_canceled.send(sender=self)
        bust_cache("requests", self.to_user.pk)
        bust_cache("sent_requests", self.from_user.pk)
        return True

    def mark_viewed(self):
        self.viewed = timezone.now()
        friendship_request_viewed.send(sender=self)
        self.save()
        bust_cache("requests", self.to_user.pk)
        return True

class Friend(models.Model):
    """ Model to represent Friendships """
    to_user = models.ForeignKey(AUTH_USER_MODEL, models.CASCADE, related_name="friends")
    from_user = models.ForeignKey(
        AUTH_USER_MODEL, models.CASCADE, related_name="_unused_friend_relation"
    )
    created = models.DateTimeField(default=timezone.now)

    objects = FriendshipManager()

    class Meta:
        verbose_name = _("Friend")
        verbose_name_plural = _("Friends")
        unique_together = ("from_user", "to_user")

    def __str__(self):
        return "User #%s is friends with #%s" % (self.to_user_id, self.from_user_id)

    def save(self, *args, **kwargs):
        # Ensure users can't be friends with themselves
        if self.to_user == self.from_user:
            raise ValidationError("Users cannot be friends with themselves.")
        super(Friend, self).save(*args, **kwargs)