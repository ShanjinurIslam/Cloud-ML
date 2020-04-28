from django.urls import path
from ml import views

urlpatterns = [
    path('models', views.availablemodels),
]