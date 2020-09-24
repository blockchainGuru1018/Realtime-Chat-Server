# File: support/view.py
# Author: Cory Chenier
# Description: used to return views and modify their context.
from django.shortcuts import render
from django.http import HttpResponseRedirect
from .forms import emailForm
from django.http import HttpResponse, HttpResponseForbidden
from .EmailService.service.Email import Email as mail


def privacy(request):
    return render(request, 'pages/privacy.html', {})


def index(request):
    return render(request, 'pages/index.html', {})


def thank_you(request):
    return render(request, 'pages/thanks.html', {})


def support(request):
    email_form = emailForm()
    if request.method == "POST":
        email_form = emailForm(request.POST)
        if email_form.is_valid():

            name = email_form.cleaned_data.get("name")
            email = email_form.cleaned_data.get("email")
            subject = email_form.cleaned_data.get("subject")
            message = email_form.cleaned_data.get("message")
            sndMail = mail(name, email, subject, message)

            if sndMail.verifyEmail(email):
                if sndMail.sendEmail() == 0:
                    return HttpResponseForbidden
                else:
                    return HttpResponseRedirect('../thanks')

        else:
            return HttpResponseRedirect('/')

    context = {
        "form": email_form
    }

    return render(request, 'pages/support.html', context)
