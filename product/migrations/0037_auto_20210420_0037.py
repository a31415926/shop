# Generated by Django 3.1.7 on 2021-04-19 21:37

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0036_remove_orderitem_cost_on_curr'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='order',
            name='cost_of_delivery_on_curr',
        ),
        migrations.RemoveField(
            model_name='order',
            name='full_amount_on_curr',
        ),
        migrations.RemoveField(
            model_name='order',
            name='total_amount_on_curr',
        ),
    ]
