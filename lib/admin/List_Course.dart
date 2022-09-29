import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import '../api/response.dart';
import '../learning_activity.dart';
import '../model/facilitator_courses_model.dart';
import '../sizeconfig.dart';



class List_Courses extends StatefulWidget {
  final email;
  final fullname;
  final userId;
  final usertype;

  List_Courses({required this.fullname,required this.email,required this.userId, required this.usertype});

  @override
  State<StatefulWidget> createState() => InitState();


}
class InitState extends State<List_Courses> {

  List<FacilitatorCoursesModel> courseList = [];

  Future<List<FacilitatorCoursesModel>> loadCourses(String _facilitatorId) async{

    var url = Api.getFacilitatorCourses;
    final response = await http.post(Uri.parse(url), body: {
      "facilitator_id_fk" : _facilitatorId,
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    if(response.statusCode == ResponseDB.successCode){
      for(Map<String, dynamic> i in jsonData){
        courseList.add(FacilitatorCoursesModel.fromJson(i));
      }
      return courseList;

    }else{
      return courseList;
    }
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("COURSES"),
        elevation: 0,
        backgroundColor: const Color(0xFF29B6F6),
                 ),
      body:  FutureBuilder(
          // initialData: const Text('No Activities'),
            future: loadCourses(widget.userId),
            builder: (context, AsyncSnapshot<List<FacilitatorCoursesModel>> snapshot) {
             /* if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError &&
                  !snapshot.hasData) {
                print('courses snapshot data is: ${snapshot.data}');

                return const CircularProgressIndicator();
              } else {*/
                return Container(
                  child: SizedBox(
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: courseList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios),
                                  onTap: (){
                                    print(snapshot.data![index].course_code);
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder:
                                            (context) => LearningActivity(courseId: snapshot.data![index].course_id_fk, email: widget.email, userId: widget.userId, usertype: widget.usertype,)
                                          ));
                                        },
                                        title: Text(snapshot.data![index].course_code +" - "+snapshot.data![index].course_description)
                                    ),
                                  );
                                },

                              ),
                            )
                        ),
                      );
                    }
                  //}
              ),
        );
  }
}
