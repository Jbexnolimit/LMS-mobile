import 'package:json_annotation/json_annotation.dart';
part 'courses_model.g.dart';

@JsonSerializable()
class CoursesModel{
  final String id;
  final String course_id_fk;
  final String learner_id_fk;
  final String course_description;
  final String course_code;




  CoursesModel({
    required this.id, required this.course_id_fk, required this.learner_id_fk, required this.course_description, required this.course_code});

  factory CoursesModel.fromJson(Map<String, dynamic> json) => _$CoursesModelFromJson(json);

  Map <String, dynamic> toJson() => _$CoursesModelToJson(this);


}