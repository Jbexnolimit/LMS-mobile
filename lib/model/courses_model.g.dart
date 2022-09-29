// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesModel _$CoursesModelFromJson(Map<String, dynamic> json) => CoursesModel(
      id: json['id'] as String,
      course_id_fk: json['course_id_fk'] as String,
      learner_id_fk: json['learner_id_fk'] as String,
      course_description: json['course_description'] as String,
      course_code: json['course_code'] as String,
    );

Map<String, dynamic> _$CoursesModelToJson(CoursesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id_fk': instance.course_id_fk,
      'learner_id_fk': instance.learner_id_fk,
      'course_description': instance.course_description,
      'course_code': instance.course_code,
    };
