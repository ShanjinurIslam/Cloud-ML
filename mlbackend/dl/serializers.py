from rest_framework import serializers
from .models import DLModel

class DLModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = DLModel
        fields = ('id','name','api_name','use_case','catagory')

