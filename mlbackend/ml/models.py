from django.db import models

# Create your models here.
class MLModel(models.Model):
    name = models.CharField(max_length=50)
    learning_method = models.CharField(max_length=50)
    catagory = models.CharField(max_length=50)

    def __str__(self):
        return self.name
    