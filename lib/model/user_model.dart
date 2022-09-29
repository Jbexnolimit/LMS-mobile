import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


@JsonSerializable()
class UserModel{
   late String usertype;
   late String course_Id;
   late String firstname;
   late  String middlename;
   late  String lastname;
   late  String email;
   late  String gender;



  UserModel(
       this.usertype,
       this.course_Id,
       this.firstname,
       this.middlename,
       this.lastname,
       this.email,
       this.gender);

   factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
   Map<String, dynamic> toJson() => _$UserModelToJson(this);

}