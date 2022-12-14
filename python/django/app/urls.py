from django.contrib.auth import views
from django.urls import path, include
from django.views.generic.base import RedirectView
from app import views
from django.conf import settings
from django.conf.urls.static import static
from django.views.decorators.csrf import csrf_exempt
from rest_framework.routers import SimpleRouter



# Urls for Authentication
routes = SimpleRouter()
routes.register(r'datalist/auth/login', views.LoginViewSet, basename='auth-login')
routes.register(r'datalist/auth/refresh', views.TokenRefreshViewSet, basename='token-refresh')




urlpatterns = [
    path('', RedirectView.as_view(url='http://127.0.0.1:8000/datalist')),
    path('datalist', views.CovidDataView.as_view()),
    path('datalist/<uuid:pk>', csrf_exempt(views.CovidDataView.as_view())),
    path('loaddata', views.LoadDataView, name='loading'),
    path('deletealldata', views.DeleteAllDataView),
    path('deleteselected', views.DeleteSelectedDataView),
    path('', include(routes.urls)),
]


if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

