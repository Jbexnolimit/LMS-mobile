// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      id: json['id'] as String,
      activityfolder_id : json['activityfolder_id'] as String,
      activity_title: json['activity_title'] as String,
      description: json['description'] as String,
      created_date: DateTime.parse(json['created_date'] as String),
      learningfile_id: json['learningfile_id'] as String,
      learning_file: json['learning_file'] as String,
      learning_filename: json['learning_filename'] as String,
      mime: json['mime'] as String,
      activity_id_fk: json['activity_id_fk'] as String,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityfolder_id': instance.activityfolder_id,
      'activity_title': instance.activity_title,
      'description': instance.description,
      'created_date': instance.created_date.toIso8601String(),
      'learningfile_id': instance.learningfile_id,
      'file': instance.learning_file,
      'file_name': instance.learning_filename,
      'mime': instance.mime,
      'activity_id_fk': instance.activity_id_fk,
    };
