// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facilitator_courses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacilitatorCoursesModel _$FacilitatorCoursesModelFromJson(
        Map<String, dynamic> json) =>
    FacilitatorCoursesModel(
      id: json['id'] as String,
      course_id_fk: json['course_id_fk'] as String,
      facilitator_id_fk: json['facilitator_id_fk'] as String,
      course_description: json['course_description'] as String,
      course_code: json['course_code'] as String,
    );

Map<String, dynamic> _$FacilitatorCoursesModelToJson(
        FacilitatorCoursesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id_fk': instance.course_id_fk,
      'facilitator_id_fk': instance.facilitator_id_fk,
      'course_description': instance.course_description,
      'course_code': instance.course_code,
    };
