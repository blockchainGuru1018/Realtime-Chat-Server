import datetime
from django.core.cache import cache
from django.conf import settings
from django.utils.deprecation import MiddlewareMixin

class ActiveUserMiddleware(MiddlewareMixin):

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        # print('ActiveUserMiddleware __call__', request.user)
        self.process_request(request)

        return response

    def process_request(self, request):
        current_user = request.user

        # print('ActiveUserMiddleware', current_user, request.user.is_authenticated)
        if request.user.is_authenticated:
            now = datetime.datetime.now()
            cache.set('seen_%s' % (current_user.username), now,
                           settings.USER_LASTSEEN_TIMEOUT)
