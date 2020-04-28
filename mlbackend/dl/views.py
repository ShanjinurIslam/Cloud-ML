from django.shortcuts import render
from django.http import JsonResponse
from .models import DLModel
from .serializers import DLModelSerializer

# Create your views here.


def availablemodels(request):
    models = DLModel.objects.all()
    serializer = DLModelSerializer(models, many=True)
    return JsonResponse({'models': serializer.data}, safe=False)

