// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as String,
      comment: json['comment'] as String,
      user_id: json['user_id'] as String,
      activity_id: json['activity_id'] as String,
      created_date: DateTime.parse(json['created_date'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'user_id': instance.user_id,
      'activity_id': instance.activity_id,
      'created_date': instance.created_date.toIso8601String(),
    };
