from django.db import models

# Create your models here.
from django.db import models

# Create your models here.
class DLModel(models.Model):
    name = models.CharField(max_length=50)
    use_case = models.CharField(max_length=50)
    catagory = models.CharField(max_length=50)

    def __str__(self):
        return self.name
    