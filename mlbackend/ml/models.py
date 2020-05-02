from django.db import models
from jsonfield import JSONField
# Create your models here.
class MLModel(models.Model):
    name = models.CharField(max_length=50)
    api_name = models.CharField(max_length=50,default="")
    learning_method = models.CharField(max_length=50)
    catagory = models.CharField(max_length=50)

    def __str__(self):
        return self.name

class MLModelExamples(models.Model):
    name  =  models.CharField(max_length=50,default="")
    model = models.ForeignKey(MLModel,on_delete=models.CASCADE)
    xlabels = models.CharField(max_length=200,default="")
    ylabel = models.CharField(max_length=50,default="")
    classes = models.CharField(max_length=200,default="")
    path = models.CharField(max_length=100,default="")

    def __str__(self):
        return str(self.model.api_name) + "_" + self.name