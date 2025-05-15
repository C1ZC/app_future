from django.test import TestCase
from django.urls import reverse

class UserRegistrationTestCase(TestCase):
    def test_user_registration_view(self):
        response = self.client.post(reverse('register'), data={
            'username': 'newuser',
            'email': 'newuser@example.com',
            'password1': 'complexpassword',
            'password2': 'complexpassword'
        })
        self.assertEqual(response.status_code, 302)  # Expecting redirect to home