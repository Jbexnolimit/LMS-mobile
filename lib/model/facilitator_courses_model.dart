import 'package:json_annotation/json_annotation.dart';
part 'facilitator_courses_model.g.dart';

@JsonSerializable()
class FacilitatorCoursesModel{
  final String id;
  final String course_id_fk;
  final String facilitator_id_fk;
  final String course_description;
  final String course_code;




  FacilitatorCoursesModel({
    required this.id, required this.course_id_fk, required this.facilitator_id_fk, required this.course_description, required this.course_code});

  factory FacilitatorCoursesModel.fromJson(Map<String, dynamic> json) => _$FacilitatorCoursesModelFromJson(json);

  Map <String, dynamic> toJson() => _$FacilitatorCoursesModelToJson(this);


}