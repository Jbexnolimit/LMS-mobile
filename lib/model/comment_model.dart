

import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel{
  final String id;
  final String comment;
  final String user_id;
  final String activity_id;
  final DateTime created_date;


  CommentModel({
    required this.id, required this.comment, required this.user_id, required this.activity_id, required this.created_date});

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map <String, dynamic> toJson() => _$CommentModelToJson(this);


  @override
  String toString() =>
      'ActivityFolderModel{id: $id, comment: $comment, user_id: $user_id, activity_id: $activity_id, created_date: $created_date}';

}