from django.db import models
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.base_user import AbstractBaseUser
from .UserManager import UserManager
from django.utils import timezone
from django.db.models import UniqueConstraint

import uuid
import logging

logger = logging.getLogger('django')


class CovidData (models.Model):
    id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False, verbose_name='id')
    infected = models.PositiveIntegerField(
        verbose_name='infected', unique=False, blank=True, null=False, default=0)
    deceased = models.PositiveIntegerField(
        verbose_name='deceased', unique=False, blank=True, null=False, default=0)
    recovered = models.PositiveIntegerField(
        verbose_name='recovered', unique=False, blank=True, null=False, default=0)
    quarantined = models.PositiveIntegerField(
        verbose_name='quarantined', unique=False, blank=True, null=False, default=0)
    tested = models.PositiveIntegerField(
        verbose_name='tested', unique=False, blank=True, null=False, default=0)
    date = models.DateField(auto_now=False, blank=True, default=timezone.now)
    time = models.TimeField(auto_now=False, blank=True, default=timezone.now)
    sourceWeb = models.CharField(
        max_length=100, null=True, blank=True, default='https://apify.com/tugkan/covid-hu')
    activeInfected = models.PositiveIntegerField(
        verbose_name='activeInfected', unique=False, blank=True, null=False, default=0)

    class Meta:
        verbose_name = 'CovidData'
        verbose_name_plural = 'CovidData'
        ordering = ('date', 'time')
        constraints = [UniqueConstraint(
            fields=['date', 'time'], name='datetime')]

    def __str__(self):
        return str(self.date) + ' ' + str(self.time)


class User (AbstractBaseUser, PermissionsMixin):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    email = models.EmailField(('email address'), unique=True, db_index=True)
    userName = None
    firstName = models.TextField(verbose_name='First Name', blank=True)
    lastName = models.TextField(verbose_name='Last Name', blank=True)
    is_staff = models.BooleanField(('staff'), default=True)
    is_active = models.BooleanField(('active'), default=True)
    is_superuser = models.BooleanField(('superuser'), default=False)
    valid = models.BooleanField(('valid'), default=True)
    dateJoined = models.DateTimeField(default=timezone.now)

    objects = UserManager()
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    class Meta:
        verbose_name = 'User'
        verbose_name_plural = 'Users'
        ordering = ('email',)

    def __str__(self):
        return self.email


