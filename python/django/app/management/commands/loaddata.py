from app.models import CovidData
from django.core.management.base import BaseCommand, CommandError
from datetime import datetime

import requests


IMPORT_URL = 'https://api.apify.com/v2/datasets/Gm6qjTgGqxkEZTkuJ/items?format=json&clean=1'

class Command(BaseCommand):
    def __init__(self):
        self.count = 0

    def import_data_from_url(self, data):
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
            self.count += 1
            print('CREATE', 'date: ', date_json, 'time: ', time_json)
        else:
            print('\nCovidData exists for this date and time: ', date_json, time_json)

    def handle(self, *args, **options):
        # try:
        headers = {'Content-Type': 'application/json'}
        response = requests.get(url=IMPORT_URL, headers=headers)
        # print(response)

        """data is tuple not dict"""
        data = response.json()
        for i, data_object in enumerate(data):
            #print(data_object)
            self.import_data_from_url(data_object)

        print('\nJson url succesfully loaded ',self.count, ' rows into database')
        # except IMPORT_URL.DoesNotExist:
        #     raise CommandError(f'URL "{IMPORT_URL}" does not exist')

