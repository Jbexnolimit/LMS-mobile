import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms/api/api.dart';
import 'package:lms/api/response.dart';


class GetProfile{
  final String email;


  GetProfile({required this.email});

  Future getProfile() async {

    try{
       var response = await http.post(Uri.parse(Api.userdata_API), body: {
          'email' : email,
      });

      if(response.statusCode == ResponseDB.successCode){
        final result = json.decode(response.body);
          return result;
      } else {
        return 'Server Error';
      }
    } catch (e) {
      return 'App Error';
    }

  }


}
class GetUserType{
  final String usertypeId;
  GetUserType({required this.usertypeId});

  Future getUsertype() async {

    try{
      var response = await http.post(Uri.parse(Api.getUserType), body: {
        'usertype_id' : usertypeId,
      });

      if(response.statusCode == ResponseDB.successCode){
        final result = json.decode(response.body);
        return result;
      } else {
        return 'Server Error';
      }
    } catch (e) {
      return 'App Error';
    }

  }

}
