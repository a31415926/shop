# Generated by Django 3.1.7 on 2021-02-26 22:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0004_auto_20210227_0001'),
    ]

    operations = [
        migrations.AddField(
            model_name='currency',
            name='disp',
            field=models.CharField(blank=True, max_length=20, null=True),
        ),
    ]
