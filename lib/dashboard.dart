import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/learning_activity.dart';
import 'package:lms/model/courses_model.dart';
import 'package:lms/model/get_profile.dart';
import 'package:lms/sizeconfig.dart';
import 'package:lms/ui/app_bar.dart';
import 'package:lms/ui/bottom_app_bar.dart';
import 'package:lms/ui/custom_card.dart';
import 'package:http/http.dart' as http;
import 'api/api.dart';
import 'api/response.dart';
import 'constant.dart';
import 'model/dashboard_model.dart';

class DashBoard extends StatelessWidget {

  final email;
  final fullname;
  final userId;
  final usertype;


   DashBoard({required this.fullname,required this.email,required this.userId, required this.usertype});


  final List<CardModel> data = [];
  final List<MenuModel> menus = [];

  void getPostData() {
    List<dynamic> responseList = cardConstant;
    for (var element in responseList) {
      data.add(CardModel.fromJson(element));
    }
    List<dynamic> responseMap = menuConstant;
    for (var menu in responseMap) {
      menus.add(MenuModel.fromJson(menu));
    }
  }

  Future addCourse(String courseCode, String learnerId) async{

      var url = Api.addCourse;
      var response = await http.post(Uri.parse(url),
          body: {
            "course_code": courseCode,
            "learner_id_fk": learnerId,
          });
      var jsonData = json.decode(response.body);
      if(jsonData == ResponseDB.Error){
        print("Error");
      }else{
        Fluttertoast.showToast(msg: "Course added successfully");
      }

  }


  @override
  Widget build(BuildContext context) {
    TextEditingController txtCourseCode = TextEditingController();
    void _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('ADD COURSE'),
              content: TextFormField(
                controller: txtCourseCode,
                decoration: const InputDecoration(
                icon: Icon(
                  Icons.add
                ),
                    hintText: "Input Course Code",
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {

                     // _dismissDialog();
                    },
                    child: const Text('CANCEL')),
                TextButton(
                  onPressed: () {
                    addCourse(txtCourseCode.text, userId);
                    return;
                  },
                  child: Text('ADD'),
                )
              ],
            );
          });
    }




    SizeConfig().init(context);
    getPostData();
    return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: appBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListViewDashboard(data: data),
            SizedBox(height: SizeConfig.blockSizeVertical! * 3.7),
            Container(
              margin:
              EdgeInsets.only(left: SizeConfig.blockSizeVertical! * 6.4),
              child: Text(
                'Courses',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: const Color(0xFF111111),
                    fontFamily: 'Poppins',
                    fontSize: SizeConfig.blockSizeHorizontal! * 4.8,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.2),
            GridViewDashboard(menus: menus, userId: userId, email: email, usertype: usertype),
          ],
        ),
        bottomNavigationBar:  CustomBottomAppBar(email: email, fullname: fullname, userId: userId, usertype: usertype,),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            isExtended: true,
            elevation: 0,
            backgroundColor: Colors.indigoAccent,
            child: const Icon(
              Icons.add,
              color: Colors.white,

            ),
            onPressed: () {
              _showMaterialDialog();
            }));
  }
}

class GridViewDashboard extends StatelessWidget {
   GridViewDashboard({Key? key,
    required this.menus,
    required this.userId, required this.email, required this.usertype})
      : super(key: key);

  final userId;
  final email;
  final usertype;
  final List<MenuModel> menus;

  List<CoursesModel> courseList = [];

  Future<List<CoursesModel>> loadCourses(String _learnerId) async{

    var url = Api.getCourses;
    final response = await http.post(Uri.parse(url), body: {
      "learner_id_fk" : _learnerId,
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    if(response.statusCode == ResponseDB.successCode){
      for(Map<String, dynamic> i in jsonData){
        courseList.add(CoursesModel.fromJson(i));
      }

      return courseList;
    }else{

      return courseList;
    }
  }



  @override
  Widget build(BuildContext context) {




    return FutureBuilder(
      // initialData: const Text('No Activities'),
        future: loadCourses(userId),
        builder: (context, AsyncSnapshot<List<CoursesModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError &&
              !snapshot.hasData) {
            print('courses snapshot data is: ${snapshot.data}');

            return const CircularProgressIndicator();
          } else {
            return Center(
              child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 86.9,
                  height: SizeConfig.blockSizeVertical! * 32.5,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: courseList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                              trailing: const Text("View",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),),
                              onTap: (){
                                print(snapshot.data![index].course_code);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder:
                                        (context) => LearningActivity(courseId: snapshot.data![index].course_id_fk, email: email, userId: userId, usertype: usertype)
                                ));
                              },
                              title: Text(snapshot.data![index].course_description)
                          ),
                        );
                      },

                    ),
                  )
              ),
            );
          }
        }

    );
  }
}

class ListViewDashboard extends StatelessWidget {
  const ListViewDashboard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<CardModel> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 32.5,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeVertical! * 6.4,
              vertical: SizeConfig.blockSizeVertical! * 3.7),
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 5.3,
            );
          },
          itemBuilder: (context, index) {
            return CustomCard(
                color: data[index].color!,
                reminders: data[index].reminders,
                notes: data[index].notes);
          }),
    );
  }
}





