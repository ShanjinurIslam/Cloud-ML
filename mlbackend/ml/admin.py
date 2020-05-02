from django.contrib import admin
from .models import MLModel,MLModelExamples
# Register your models here.

admin.site.register(MLModel)
admin.site.register(MLModelExamples)