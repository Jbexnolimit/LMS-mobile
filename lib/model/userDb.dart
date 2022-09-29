import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms/api/api.dart';
import 'package:lms/api/response.dart';


class UserDB{
  final String email;
  UserDB({required this.email});

  Future getData() async{

   try{

     final response = await http.post(
         Uri.parse(Api.userdata_API), body: {
       'email': email,
     });
     if(response.statusCode == ResponseDB.successCode){
       final result = json.decode(response.body);
       if(result != ResponseDB.noDataFound){
         return result;
       }
       else{
         return ResponseDB.noDataFound;
       }
     }
     else{
       return ResponseDB.noDataFound;

     }

   }catch (e) {

     return ResponseDB.noDataFound;

   }

  }

}