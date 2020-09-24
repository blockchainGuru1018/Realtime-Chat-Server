"""
WSGI config for WeaveChat project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""

import os, sys
import inspect
import pathlib
FILENAME = inspect.getframeinfo(inspect.currentframe()).filename
PROJECTPATH = pathlib.Path(os.path.dirname(os.path.abspath(FILENAME)))
ROOTPATH = PROJECTPATH.parent
sys.path.append(str(ROOTPATH))


from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'WeaveChat.settings')

application = get_wsgi_application()
