from app.models import CovidData
from django.core.management.base import BaseCommand
from django.db.models import Q

import datetime
import six


class Command(BaseCommand):
    def handle(self, *args, **options):
        answer= input('Delete all data from database (y) or remain some for test(n) or quit (q)?')
       
        while len(answer) < 1 or answer[0].lower() not in "ynq":
            answer = input("Please answer yes(y) or no(y) or quit(q): ")

        if answer == 'y':
            CovidData.objects.all().delete()
            print('\nSuccesfully delete all CovidData from database')
        else:
            if answer == 'n':
                c1 = Q(date=datetime.date(2022, 4, 5)) & Q(time=datetime.time(7, 0, 0))
                c2 = Q(date=datetime.date(2022, 4, 7)) & Q(time=datetime.time(10, 0, 0))
                data = CovidData.objects.filter(~c1 & ~c2)
                count = data.count()
                data.delete()
                print('\nSuccesfully delete', count, 'CovidData from database')
                print('2rows remain in database')
            else:
                if answer == 'q':
                    return False
