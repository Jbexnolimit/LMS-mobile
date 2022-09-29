
import 'package:json_annotation/json_annotation.dart';
part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel{
  final String id;
  final String activityfolder_id;
  final String activity_title;
  final String description;
  final DateTime created_date;
  final String learningfile_id;
  final String learning_file;
  final String learning_filename;
  final String mime;
  final String activity_id_fk;


  ActivityModel({
    required this.id, required this.activityfolder_id, required this.activity_title, required this.description, required this.created_date,
    required this.learningfile_id,required this.learning_file, required this.learning_filename, required this.mime, required this.activity_id_fk});

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map <String, dynamic> toJson() => _$ActivityModelToJson(this);



}