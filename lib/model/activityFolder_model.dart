
import 'package:json_annotation/json_annotation.dart';
part 'activityFolder_model.g.dart';

@JsonSerializable()
class ActivityFolderModel{
   final String id;
   final String activity_title;
   final String course_id;
   final DateTime created_date;

  ActivityFolderModel({
      required this.id, required this.activity_title, required this.course_id, required this.created_date});

factory ActivityFolderModel.fromJson(Map<String, dynamic> json) => _$ActivityFolderModelFromJson(json);

Map <String, dynamic> toJson() => _$ActivityFolderModelToJson(this);


  @override
  String toString() =>
      'ActivityFolderModel{id: $id, activity_title: $activity_title, course_id: $course_id, created_date: $created_date}';


}