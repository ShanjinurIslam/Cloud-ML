from rest_framework import serializers
from .models import MLModel,MLModelExamples

class MLModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = MLModel
        fields = ('id','name','api_name','learning_method','catagory')

class MLModelExamplesSerializer(serializers.ModelSerializer):
    class Meta:
        model = MLModelExamples
        fields = ('id','name','xlabels','ylabel','classes','accuracy')