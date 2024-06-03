// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModels _$TodoModelsFromJson(Map<String, dynamic> json) => TodoModels(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$TodoModelsToJson(TodoModels instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'isDone': instance.isDone,
    };
