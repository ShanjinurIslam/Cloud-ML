from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from utils.models import ServerStatus
from ml.models import MLModel
from dl.models import DLModel
# Create your views here.


def status(request):
    total = MLModel.objects.all().count() + DLModel.objects.all().count()
    status = ServerStatus.objects.get(pk=1)
    return JsonResponse({'status': status.status, 'number_models': total}, safe=False)
