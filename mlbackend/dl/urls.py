from django.urls import path
from dl import views

urlpatterns = [
    path('models', views.availablemodels),
]