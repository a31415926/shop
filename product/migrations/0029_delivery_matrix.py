# Generated by Django 3.1.7 on 2021-04-16 11:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0028_pricematrix_pricematrixitem'),
    ]

    operations = [
        migrations.AddField(
            model_name='delivery',
            name='matrix',
            field=models.ForeignKey(blank=True, default=None, null=True, on_delete=django.db.models.deletion.PROTECT, to='product.pricematrix'),
        ),
    ]
