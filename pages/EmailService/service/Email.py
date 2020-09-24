import re
from django.core.mail import BadHeaderError, send_mail
from WeaveChat.settings import EMAIL_HOST_USER
from django.http import HttpResponseForbidden
class Email:
    name = None
    eAddress = None
    subject = None
    message = None

    def __init__(self, name,address,sub,message):
        self.name = name
        self.eAddress = address
        self.subject = sub
        self.message = message

    def verifyEmail(self,email):
        regex = '^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$'

        if re.search(regex,email):
            return True
        else:
            return False

    def sendEmail(self):

        subject = None

        if self.subject == 'service':
            subject = 'General Customer Service'
        elif self.subject == 'suggestions':
            subject = 'Suggestions'
        elif self.subject == 'product':
            subject = 'Product Support'
        try:
            if send_mail('iωeave: ' + subject, 'Message from: ' + self.name + ', ' + self.eAddress + '\n' + self.message, EMAIL_HOST_USER, [EMAIL_HOST_USER], fail_silently=False) == 0:
                return 0
        except BadHeaderError:
            return HttpResponseForbidden
