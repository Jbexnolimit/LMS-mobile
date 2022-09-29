

import 'package:flutter/cupertino.dart';
import 'package:lms/api/response.dart';
import 'package:lms/model/userDb.dart';
import 'package:lms/model/userHelper.dart';

class GlobalProvider extends ChangeNotifier{


   UserHelper _userDetails = UserHelper();
  UserHelper get userDetails => _userDetails;

  void getUserData(String email){
    UserDB(email: email).getData().then((value) {

      if(value != ResponseDB.noDataFound) {
        UserHelper holder = UserHelper();
        holder.id = value[0]['id'];
        holder.firstname = value[0]['firstname'];
        holder.middlename = value[0]['middlename'];
        holder.lastname = value[0]['lastname'];
        holder.course_id = value[0]['course_id'];
        holder.email = value[0]['email'];
        holder.usertype_id = value[0]['usertype_id'];

        _userDetails = holder;

        print(_userDetails.email);
      } else {
        print('No Data Found');
      }
    });

  }

}