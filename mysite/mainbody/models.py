from django.db import models

# Create your models here.
#媒体信息列表
class content_media(models.Model):
    id = models.AutoField(primary_key=True)
    create_time=models.DateTimeField()
    name=models.CharField(max_length=40)
    size=models.CharField(max_length=15)
    path=models.CharField(max_length=200)
    duration=models.CharField(max_length=12,default='00:00:00:00')

#任务流列表
class task_stream(models.Model):
    id = models.AutoField(primary_key=True)
    create_time=models.DateTimeField()
    name = models.CharField(max_length=40)
    pack = models.CharField(max_length=40)