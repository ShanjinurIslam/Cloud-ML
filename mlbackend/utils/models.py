from django.db import models

class ServerStatus(models.Model):
    status = models.CharField(max_length=50)