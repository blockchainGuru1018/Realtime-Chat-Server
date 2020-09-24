from django import forms
from captcha.fields import ReCaptchaField
from captcha.widgets import ReCaptchaV2Checkbox
from WeaveChat.settings import RECAPTCHA_PRIVATE_KEY,RECAPTCHA_PUBLIC_KEY


class emailForm(forms.Form):

    name = forms.CharField(label = 'Name', widget=forms.TextInput(attrs={
       "class": "form-control",
       "id": "name",
       "placeholder": "Enter name" }))
    email = forms.EmailField(label = 'Email Address', widget = forms.EmailInput(attrs={
       "class": "form-control",
       "id": "email",
       "placeholder": "Enter email"
    }))
    subject_choice = (("service","General Customer Service"),("suggestions","Suggestions"),("product","Product Support"))
    subject = forms.ChoiceField(label = 'Subject', choices = subject_choice,  widget = forms.Select(attrs = {
        "class" : "form-control",
        "id": "subject",
        "placeholder": "Choose one"
    }))
    message = forms.CharField(required = True, label = 'Message', widget = forms.Textarea(attrs={
        "class": "form-control",
        "id":"message",
        "rows":9,
        "cols":25}))
    captcha = ReCaptchaField(public_key=RECAPTCHA_PUBLIC_KEY, private_key=RECAPTCHA_PRIVATE_KEY, widget=ReCaptchaV2Checkbox)