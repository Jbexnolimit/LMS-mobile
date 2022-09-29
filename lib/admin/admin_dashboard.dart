import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import '../api/response.dart';
import '../learning_activity.dart';
import '../login_screen.dart';
import '../model/facilitator_courses_model.dart';
import 'List_Course.dart';
import 'Upload_File.dart';
import 'VerifyLearners.dart';


class AdminDashboard extends StatefulWidget {
  final email;
  final fullname;
  final userId;
  final usertype;

  AdminDashboard({this.fullname ="",this.email ="", this.userId ="",this.usertype=""});

  @override
  State<StatefulWidget> createState() => InitState();
}


class InitState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold( extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF29B6F6),

      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
             UserAccountsDrawerHeader(
              accountName: Text(widget.fullname, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.0),),
              accountEmail: Text(widget.email,style: const TextStyle(color: Colors.black)),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("images/city.png"),
                backgroundColor: Colors.white,
              ),
              decoration: const BoxDecoration(color: Colors.lightBlueAccent),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: (){

              },
            ),
            const Divider(),
              Row(
                  children: const [

                    Text("     COURSES",
                      style:
                      TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start

                ),

                loadCourses(),

            const Divider(),
                ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Log out"),
                onTap: () {
                  Navigator.push(context, PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: const LoginScreen()));
                  //=>Navigator.of(context).push(
                  //  MaterialPageRoute(
                  //     builder: (BuildContext context) => LoginScreen() )
                  // ),
                }
            ),
          ],
        ),
      ),

      backgroundColor: Color(0xFF29B6F6),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 115,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style:  TextStyle(
                          color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Image.asset(
                    "assets/notification.png",
                    width: 24,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GridDashboard(fullname: widget.fullname, email: widget.email, userId: widget.userId, usertype: widget.usertype,)
        ],
      ),
    );
  }


  Widget loadCourses(){

   return FutureBuilder(
      // initialData: const Text('No Activities'),
        future: _loadCourses(widget.userId),
        builder: (context, AsyncSnapshot<List<FacilitatorCoursesModel>> snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError &&
                  !snapshot.hasData) {
                print('courses snapshot data is: ${snapshot.data}');

                return const CircularProgressIndicator();
              } else {
                  return
                    Center(
                      child :
                          SingleChildScrollView(
                            child:
                                  SizedBox(
                                height: 320,
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
                                                    (context) => LearningActivity(courseId: snapshot.data![index].course_id_fk, email: widget.email, userId: widget.userId, usertype: widget.usertype)
                                            ));
                                          },
                                          title: Text(snapshot.data![index].course_code +" : "+snapshot.data![index].course_description)
                                      ),
                      );
                        },
                      )
                    ),
                          )
                  );
                }
              }
            );
          }

  List<FacilitatorCoursesModel> courseList = [];

  Future<List<FacilitatorCoursesModel>> _loadCourses(String _facilitatorId) async{

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



}


class GridDashboard extends StatelessWidget {

  final email;
  final fullname;
  final userId;
  final usertype;


  GridDashboard({required this.fullname,required  this.email,required  this.userId, required this.usertype});

  Items item1 = Items(
      title: "Verify Learners",
      img: "assets/images/learning.png",
      route: "verifylearner"
  );

  Items item2 = Items(
      title: "Upload File",
      img: "assets/images/learning.png",
      route: "uploadfile"
  );
  Items item3 = Items(
      title: "Courses",
      img: "assets/images/learning.png",
      route: "courses"
  );
  Items item4 = Items(
      title: "Reminders",
      img: "assets/images/learning.png",
      route: "reminders"
  );



  getRoute(String _route, BuildContext context){
    switch(_route){

      case 'verifylearner':
        return  Navigator.of(context).push(MaterialPageRoute(
            builder:
                (context) => VerifyLearners()
        ));
      case 'uploadfile':
        return  Navigator.of(context).push(MaterialPageRoute(
            builder:
                (context) => UploadFile()
        ));
      case 'courses':
        print(fullname);
        print(email);
        print(userId);
        return Navigator.push(context, MaterialPageRoute(builder: (context)=> List_Courses(
          fullname: fullname,
          email: email, userId: userId,
               usertype: usertype, ),),);
      case 'reminders':
        return  Navigator.of(context).push(MaterialPageRoute(
            builder:
                (context) => AdminDashboard()
        ));


    }

  }

  @override
  Widget build(BuildContext context) {

    List<Items> myList = [item1, item2, item3, item4];
    var color = 0xFFB3E5FC;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {

            return InkWell(
              onTap: (){
                getRoute(data.route, context);
              },

              child: Container(
                decoration: BoxDecoration(
                    color: Color(color), borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),

                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String img;
  String route;

  Items({required this.title, required this.img, required this.route});
}
