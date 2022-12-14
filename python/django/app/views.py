from app.serializers import CovidSerializer, UserSerializer, LoginSerializer, RegisterSerializer
from .models import CovidData, User
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from datetime import datetime
from django.http.response import HttpResponse
from django.shortcuts import reverse
from django.http import HttpResponseRedirect
import json
import requests
from django.core.exceptions import ObjectDoesNotExist
from rest_framework import status, viewsets, filters #serializers
from rest_framework.viewsets import ModelViewSet
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import JSONParser, MultiPartParser, FormParser
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly, AllowAny



from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.exceptions import TokenError, InvalidToken
from rest_framework.decorators import permission_classes


IMPORT_URL = 'https://api.apify.com/v2/datasets/Gm6qjTgGqxkEZTkuJ/items?format=json&clean=1'



@method_decorator(csrf_exempt, name='dispatch')
class CovidDataView(APIView):
    parser_classes = (JSONParser, MultiPartParser, FormParser)

    def get(self, request, *args, **kwargs):
        serializer = CovidSerializer(CovidData.objects.all(), many=True)
        return Response(serializer.data)

    @permission_classes((IsAuthenticated,))
    def post(self, request, format=None):
        serializer = CovidSerializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response("Added Successfully")
        else:
            error_list = [serializer.errors[error][0] for error in serializer.errors]
            error_list.insert(0, "Failed to Add!\n")
            return Response(error_list)
 
    @permission_classes((IsAuthenticated,))
    def patch(self, request, *args, **kwargs):
        coviddata = CovidData.objects.get(id=request.data.get('id'))
        serializer = CovidSerializer(coviddata, data=request.data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response("Updated Successfully")
        else:
            error_list = [serializer.errors[error][0]
            for error in serializer.errors]
            error_list.insert(0, "Failed to Update!\n")
            return Response(error_list)

    @permission_classes((IsAuthenticated,))
    def delete(self, request, pk, format=None):
        coviddata = CovidData.objects.get(id=pk)
        coviddata.delete()
        return Response("Deleted Successfully")


@method_decorator(csrf_exempt, name='dispatch')
@permission_classes((IsAuthenticatedOrReadOnly,))
def LoadDataView(request, *args, **kwargs):
    count = 0
    count_exist = 0
    method = ''

    if request.method=='GET': 
        method = 'GET' #calling from Django LoadData button
        headers = {'Content-Type': 'application/json'}

        response = requests.get(url=IMPORT_URL, headers=headers)

        if status.is_success(response.status_code):
            loaded = True
            datalist = response.json()
         
        else:
            loaded = False
            str = "\nError! Failed to load data from Json url"

    elif request.method=='POST': 
        method = 'POST' #calling from React LoadData button
        data = request.body
        data_unicode= data.decode('utf-8')
        datalist = json.loads(data_unicode)

    if (method == 'POST') or (loaded is True):

        for i, data in enumerate(datalist):
            #print(i, data)
            infected_json = int(data.get('infected', None) or 0)
            deceased_json = int(data.get('deceased', None) or 0)
            recovered_json = int(data.get('recovered', None) or 0)
            quarantined_json = int(data.get('quarantined', None) or 0)
            tested_json = int(data.get('tested', None) or 0)
            date_json = datetime.date(datetime.strptime(
                data.get('lastUpdatedAtApify', None), '%Y-%m-%dT%H:%M:%S.%fZ'))
            time_json = datetime.time(datetime.strptime(
                data.get('lastUpdatedAtApify', None), '%Y-%m-%dT%H:%M:%S.%fZ'))
            sourceWeb_json = data.get('readMe', None)
            try:
                activeInfected_json = int(data.get('activeInfected', None) or 0)
            except ObjectDoesNotExist:
                activeInfected_json = 0

            obj, created = CovidData.objects.get_or_create(date=date_json, time=time_json,
                    defaults={'infected': infected_json, 'activeInfected': activeInfected_json,
                                'deceased': deceased_json, 'recovered': recovered_json,
                                'quarantined': quarantined_json, 'tested': tested_json, 'date': date_json,
                                'time': time_json, 'sourceWeb': sourceWeb_json})
            if created:
                count += 1
                print('CREATE', 'date: ', date_json, 'time: ', time_json)
            else:
                count_exist += 1
                print('\nCovidData exists for this date and time: ',date_json, time_json)

        strcount = count.__str__()
        strexist = count_exist.__str__()
        str = "\nAlready " + strexist + " data on same date and time exist in database or duplicated in Json url."
        str = str + "\nSuccesfully loaded " + strcount + " rows into database"
    
    print(str)

    #response to React call
    if (method == 'POST'): return HttpResponse(str, content_type="text/plain") 

    #response to Django call
    if (method == 'GET'): 
        url = reverse('admin:app_coviddata_changelist')
        try:
            del request.session['msg']
            request.session.modified = True
        except KeyError:
            None
        request.session['msg']= str

        return HttpResponseRedirect(url)



@method_decorator(csrf_exempt, name='dispatch')
@permission_classes((IsAuthenticated,))
def DeleteAllDataView(request):
    count = CovidData.objects.all().count()
    CovidData.objects.all().delete()
    
    strcount = count.__str__()
    str = "\nSuccesfully deleted " + strcount + " rows in database"
    print(str)

    return HttpResponse(str, content_type="text/plain")



@method_decorator(csrf_exempt, name='dispatch')
@permission_classes((IsAuthenticated,))
def DeleteSelectedDataView(request):
    count = 0
    deleted = 0
    selected = request.body
    selected_unicode = selected.decode('utf-8')
    selectedarray = json.loads(selected_unicode)
    count = len(selectedarray)
    for data in selectedarray:
        coviddata = CovidData.objects.get(id=data)
        coviddata.delete()
        deleted += 1
    strcount = count.__str__() 
    strdeleted = deleted.__str__()
    str = "\nSuccesfully deleted " + strdeleted + " data from " + strcount + " selected"
    print(str)
    
    return HttpResponse(str, content_type="text/plain")



class LoginViewSet(ModelViewSet, TokenObtainPairView):
    serializer_class = LoginSerializer
    permission_classes = (AllowAny,)
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])

        return Response(serializer.validated_data, status=status.HTTP_200_OK)





class TokenRefreshViewSet(viewsets.ViewSet, TokenRefreshView):
    permission_classes = (AllowAny,)
    http_method_names = ['post']

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])

        return Response(serializer.validated_data, status=status.HTTP_200_OK)



