# Generated by Django 3.0 on 2022-03-25 17:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mainbody', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='task_stream',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('create_time', models.DateTimeField()),
                ('name', models.CharField(max_length=40)),
                ('pack', models.CharField(max_length=40)),
            ],
        ),
    ]
