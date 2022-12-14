from .models import CovidData, User
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.urls import path
from django.http import HttpResponseRedirect
from django.core.management import call_command
from app import views


admin.site.site_header = 'Admin'
admin.site.index_title = 'Admin user page'


class UserAdmin(UserAdmin):
    model = User

    def group(self, user):
        groups = []
        for group in user.groups.all():
            groups.append(group.name)
        return ' '.join(groups)
    group.short_description = 'Groups'

    list_display = ['email', 'firstName', 'lastName', 'dateJoined', 'last_login',
                    'group', 'is_superuser', 'is_staff']
    list_filter = ['email', 'groups', 'is_superuser', 'is_staff', 'is_active', 'valid']
    fieldsets = (
        (None, {'fields': ('email', 'password', 'firstName', 'lastName')}),
        ('Permissions', {'classes': ('collapse',),
                         'fields': ('is_superuser', 'is_staff', 'is_active', 'valid')}),
        ('Important Dates', {'fields': ('dateJoined', 'last_login')}),
        ('Group Permissions', {'classes': ('collapse',), 
                                'fields': ('groups', 'user_permissions')}),
    )
    add_fieldsets = (
        (None, {'classes': ('wide',),
                'fields': ('email', 'password1', 'password2', 'firstName', 'lastName',
                           'is_superuser', 'is_staff', 'is_active', 'valid')}),
        ('Group Permissions', {'classes': ('wide',),
                               'fields': ('groups', 'user_permissions')})
    )

    search_fields = ['email']
    ordering = ['email']
    readonly_fields = ['dateJoined', 'last_login']
    filter_horizontal = ('groups', 'user_permissions')


class CovidDataAdmin(admin.ModelAdmin):
    change_list_template = '../templates/loaddata.html'

    """ returns infected data with commas as thousands separators in the admin display """
    @admin.display(description='infected')
    def infected_display (self, obj):
        return '{:,}'.format(obj.infected)
    
    @admin.display(description='deceased')
    def deceased_display(self, obj):
        return '{:,}'.format(obj.deceased)

    @admin.display(description='recovered')
    def recovered_display(self, obj):
        return '{:,}'.format(obj.recovered)

    @admin.display(description='quarantined')
    def quarantined_display(self, obj):
        return '{:,}'.format(obj.quarantined)

    @admin.display(description='tested')
    def tested_display(self, obj):
        return '{:,}'.format(obj.tested)

    @admin.display(description='activeInfected')
    def activeInfected_display(self, obj):
        return '{:,}'.format(obj.activeInfected)

    fields = ['id', 'date', 'time', 'infected', 'activeInfected', 'deceased', 'recovered', 'quarantined', 
              'tested', 'sourceWeb']
    list_display = ['date', 'time', 'infected_display', 'activeInfected_display','deceased_display', 
                    'recovered_display', 'quarantined_display', 'tested_display','sourceWeb']
    list_filter = ['date']
    search_fields = ['date']
    ordering = ['-date', '-time']
    readonly_fields = ['id']


admin.site.register(CovidData, CovidDataAdmin)
admin.site.register(User, UserAdmin)




