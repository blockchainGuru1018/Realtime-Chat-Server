# Generated by Django 2.2.8 on 2020-08-04 19:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0012_auto_20200804_1416'),
    ]

    operations = [
        migrations.AlterField(
            model_name='event',
            name='end_date',
            field=models.DateField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='event',
            name='start_date',
            field=models.DateField(blank=True, null=True),
        ),
        migrations.CreateModel(
            name='EventDate',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField()),
                ('event', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='dates', to='api.Event')),
            ],
        ),
    ]
