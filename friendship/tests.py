from django.contrib.auth import get_user_model

from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.authtoken.models import Token
from api.models import PhoneToken
from .models import Friend
# Create your tests here.
User = get_user_model()

class FriendTests(APITestCase):
    @staticmethod
    def setup_user():
        user = User.objects.create_user(
            username='user1',
            email='user1@email.com',
            phone_number='+14387942371',
            is_location=True
        )
        return User.objects.create_user(
            username='user2',
            email='user2@email.com',
            phone_number='+14387942372',
        )

    def setUp(self):
        self.user = self.setup_user()
        self.friend_id = self.user.pk - 1
        self.token = Token.objects.create(user=self.user)
        self.token.save()

    def test_create_friend_request(self):
        url = '/api/friends/'
        self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token.key)
        data = {'user_id': self.friend_id, 'message': "Test"}
        response = self.client.post(url, data)

        self.assertEqual(len(Friend.objects.all()), 1)
        # self.assertEqual(response.status_code, status.HTTP_200_OK)
        # self.assertEqual(len(response.data), 1)
