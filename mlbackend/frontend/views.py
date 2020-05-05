from django.shortcuts import render
from ml.models import MLModel
from dl.models import DLModel

# Create your views here.
def home(request):
    mlmodels = MLModel.objects.all()
    dlmodels = DLModel.objects.all()
    return render(request,'frontend/welcome.html',{'mlmodels':mlmodels,'dlmodels':dlmodels,'nbar':'home'})

def about(request):
    return render(request,'frontend/about.html',{'nbar':'about'})