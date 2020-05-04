from django.urls import path
from ml import views

urlpatterns = [
    path('models', views.availablemodels),
    path('modelexamples/<str:model_name>', views.load_model_examples),
    path('linear_svc/<int:example_id>',views.linear_svc),
    path('nbc/<int:example_id>',views.nbc)
]
