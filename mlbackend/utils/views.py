from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from utils.models import ServerStatus
# Create your views here.


def status(request):
    status = ServerStatus.objects.get(pk=1)
    return JsonResponse({'status': status.status}, safe=False)
