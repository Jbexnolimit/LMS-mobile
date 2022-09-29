// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['usertype'] as String,
      json['course_Id'] as String,
      json['firstname'] as String,
      json['middlename'] as String,
      json['lastname'] as String,
      json['email'] as String,
      json['gender'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'usertype': instance.usertype,
      'course_Id': instance.course_Id,
      'firstname': instance.firstname,
      'middlename': instance.middlename,
      'lastname': instance.lastname,
      'email': instance.email,
      'gender': instance.gender,
    };
