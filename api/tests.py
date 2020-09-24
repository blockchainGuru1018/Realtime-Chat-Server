from django.contrib.auth import get_user_model

from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from rest_framework.authtoken.models import Token
from api.models import PhoneToken
# Create your tests here.
User = get_user_model()

# class AuthTests(APITestCase):
#     def test_create_account(self):
#         url = '/api/generateToken'
#         data = {'phone_number': '+14387942375'}
#         response = self.client.post(url, data, format='json')
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#         self.assertEqual(PhoneToken.objects.count(), 1)

#         pk = response.data['pk']
#         otp = PhoneToken.objects.get(pk=pk).otp
#         url = '/api/validateToken'
#         data = {'pk': pk, 'otp': otp}
#         response = self.client.post(url, data, format='json')
#         self.assertEqual(response.status_code, status.HTTP_200_OK)

# class UserTests(APITestCase):
#     @staticmethod
#     def setup_user():
#         User.objects.create_user(
#             username='user1',
#             email='test1@email.com',
#             phone_number='+14387942371',
#             is_location=True
#         )
#         return User.objects.create_user(
#             username='testuser',
#             email='test@email.com',
#             phone_number='+14387942375',
#         )

#     def setUp(self):
#         self.user = self.setup_user()
#         self.token = Token.objects.create(user=self.user)
#         self.token.save()

#     def test_list(self):
#         url = '/api/users/'
#         self.client.credentials(HTTP_AUTHORIZATION='Token ' + self.token.key)
#         response = self.client.get(url)
#         self.assertEqual(response.status_code, status.HTTP_200_OK)
#         self.assertEqual(len(response.data), 1)
