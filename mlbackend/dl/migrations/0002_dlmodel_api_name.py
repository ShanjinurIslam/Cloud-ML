# Generated by Django 3.0.5 on 2020-05-02 22:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dl', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='dlmodel',
            name='api_name',
            field=models.CharField(default='', max_length=50),
        ),
    ]
