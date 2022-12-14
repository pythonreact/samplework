from enum import unique
from rest_framework import serializers
from .models import CovidData, User
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.settings import api_settings
from django.contrib.auth.models import update_last_login
from django.core.exceptions import ObjectDoesNotExist



class CovidSerializer(serializers.Serializer):
    id = serializers.UUIDField()
    infected = serializers.IntegerField(required=False, max_value=None, min_value=0)
    deceased = serializers.IntegerField(required=False, max_value=None, min_value=0)
    recovered = serializers.IntegerField(required=False, max_value=None, min_value=0)
    quarantined = serializers.IntegerField(required=False, max_value=None, min_value=0)
    tested = serializers.IntegerField(required=False, max_value=None, min_value=0)
    activeInfected = serializers.IntegerField(required=False, max_value=None, min_value=0)
    sourceWeb = serializers.CharField(required=False, max_length=100)
    date = serializers.DateField()
    time = serializers.TimeField()


    """validate date and time are unique together """    
    def validate(self, values):
        is_update = CovidData.objects.filter(id=values['id'])

        try:
            obj=CovidData.objects.get(date=values['date'], time=values['time']) 
        except CovidData.DoesNotExist:
            return values 
        else: #If database contains data with same date and same time 
            if not is_update:
                raise serializers.ValidationError('Date with time already exists')
            else:
                if obj.id==values['id']: #update with the same id data
                    return values
                else: #update and try overwrite with other data with same date and time
                    raise serializers.ValidationError('Date with time already exists')



    def create (self, validated_data):
        return CovidData.objects.create(**validated_data)
  
    def update (self, instance, validated_data):
        instance.date = validated_data.get('date', instance.date)
        instance.time = validated_data.get('time', instance.time)
        instance.infected = validated_data.get('infected', instance.infected)
        instance.activeInfected = validated_data.get('activeInfected', instance.activeInfected)
        instance.deceased = validated_data.get('deceased', instance.deceased)
        instance.recovered = validated_data.get('recovered', instance.recovered)
        instance.quarantined = validated_data.get('quarantined', instance.quarantined)
        instance.tested = validated_data.get('tested', instance.tested)
        instance.sourceWeb = validated_data.get('sourceWeb', instance.sourceWeb)

        instance.save()
        return instance


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"


class LoginSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        refresh = self.get_token(self.user)

        data['user'] = UserSerializer(self.user).data
        data['refresh'] = str(refresh)
        data['access'] = str(refresh.access_token)

        if api_settings.UPDATE_LAST_LOGIN:
            update_last_login(None, self.user)

        return data



class RegisterSerializer(UserSerializer):
    password = serializers.CharField(max_length=128, min_length=8, write_only=True, required=True)
    email = serializers.EmailField(required=True, write_only=True, max_length=128)

    class Meta:
        model = User
        fields = "__all__"

    def create(self, validated_data):
        try:
            user = User.objects.get(email=validated_data['email'])
        except ObjectDoesNotExist:
            user = User.objects.create_user(**validated_data)
        return user

