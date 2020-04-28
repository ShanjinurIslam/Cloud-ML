from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from .serializers import MLModelSerializer
from .models import MLModel
# Create your views here.


def availablemodels(request):
    models = MLModel.objects.all()
    serializer = MLModelSerializer(models,many=True)
    return JsonResponse({'models': serializer.data}, safe=False)

