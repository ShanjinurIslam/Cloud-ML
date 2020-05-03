from django.shortcuts import render,get_object_or_404
from django.http import HttpResponse, JsonResponse
from rest_framework.decorators import api_view
from .serializers import MLModelSerializer,MLModelExamplesSerializer
from .models import MLModel,MLModelExamples
from .ml_models import load_linear_svc
import numpy as np
# Create your views here.

@api_view(['GET'])
def availablemodels(request):
    models = MLModel.objects.all()
    serializer = MLModelSerializer(models,many=True)
    return JsonResponse({'models': serializer.data}, safe=False)

@api_view(['GET'])
def load_model_examples(request,model_name):
    model = get_object_or_404(MLModel,api_name=model_name)
    examples = MLModelExamples.objects.filter(model=model)
    serializer = MLModelExamplesSerializer(examples,many=True)
    return JsonResponse({'model_name': model_name,'examples':serializer.data}, safe=False)

@api_view(['POST'])
def linear_svc(request,example_id):
    data = request.data['data']
    data = data.split(',')
    data = [float(x) for x in data]
    prediction = load_linear_svc(example_id,data)
    return JsonResponse({'prediction': prediction}, safe=False)
