// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activityFolder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityFolderModel _$ActivityFolderModelFromJson(Map<String, dynamic> json) =>
    ActivityFolderModel(
      id: json['id'] as String,
      activity_title: json['activity_title'] as String,
      course_id: json['course_id'] as String,
      created_date: DateTime.parse(json['created_date'] as String),
    );

Map<String, dynamic> _$ActivityFolderModelToJson(
        ActivityFolderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity_title': instance.activity_title,
      'course_id': instance.course_id,
      'created_date': instance.created_date.toIso8601String(),
    };
