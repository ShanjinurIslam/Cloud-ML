# Generated by Django 3.0.5 on 2020-05-02 19:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ml', '0003_mlmodel_api_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='mlmodelexamples',
            name='path',
            field=models.CharField(default='', max_length=100),
        ),
        migrations.AlterField(
            model_name='mlmodel',
            name='api_name',
            field=models.CharField(default='', max_length=50),
        ),
    ]
