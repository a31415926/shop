# Generated by Django 3.1.7 on 2021-03-14 00:26

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0014_auto_20210314_0224'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='order',
            options={'permissions': (('change_status', 'Can change status order'),)},
        ),
    ]
