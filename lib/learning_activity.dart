import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lms/api/api.dart';
import 'package:lms/api/response.dart';
import 'package:lms/learning_page.dart';
import 'package:lms/model/activityFolder_model.dart';



class LearningActivity extends StatefulWidget {
    final courseId;
    final email;
    final userId;
    final usertype;

     LearningActivity({Key? key, required this.courseId,required this.email, required this.userId, required this.usertype}) : super(key: key);

  @override
  _learningActivityState createState() => _learningActivityState();

}


class _learningActivityState extends State<LearningActivity>{


  List<ActivityFolderModel> activityList = [];


  Future<List<ActivityFolderModel>> getActivityFolder(String course_id) async{

    var url = Api.activityfolder_API;
    final response = await http.post(Uri.parse(url), body: {
        "course_id" : course_id,
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    if(response.statusCode == ResponseDB.successCode){
      for(Map<String, dynamic> i in jsonData){

        activityList.add(ActivityFolderModel.fromJson(i));

      }

        return activityList;
    }else{
      return activityList;
    }
  }

  bool isShow(String _usertype){
      if(_usertype=='0' || _usertype=="0"){
        return true;
      }else{
        return false;
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
                        title: const Text("Activity Folders"),
                        leading: GestureDetector(
                          onTap: () { Navigator.pop(context); },
                                child: const Icon(
                                  Icons.arrow_back_sharp,  // add custom icons also
                                ),
                              ),
                              actions:  [
                                Visibility(
                                    visible: isShow(widget.usertype),
                                  child: IconButton(
                                    onPressed: ()
                                    { showFolderDialog(); },
                                    icon: Icon(Icons.add_circle_outline),
                                    iconSize: 30,
                                    ),
                                    )
                                    ] ,

          backgroundColor: Colors.lightBlueAccent,
        ),
        body:
        FutureBuilder(
           // initialData: const Text('No Activities'),
            future: getActivityFolder(widget.courseId),
            builder: (context, AsyncSnapshot<List<ActivityFolderModel>> snapshot){

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if(snapshot.hasError &&
                  !snapshot.hasData){
                print('activities snapshot data is: ${snapshot.data}');

                return const  CircularProgressIndicator();

              }else if(snapshot.data == null)
                {
                  return const Center(
                    child:
                      Text("No Activities",
                        style:TextStyle(
                        letterSpacing: 1, fontWeight: FontWeight.bold,
                        fontSize: 12
                              ),
                                  ),
                                  );

                }else{

                return ListView.builder(
                    itemCount: activityList.length,
                    itemBuilder: (context, index){

                      return  Expanded(
                          child:
                        Card(
                          child:
                          InkWell(

                            onTap: (){
                             print(snapshot.data![index].activity_title.toString());
                             print(widget.email);
                             Navigator.of(context).push(MaterialPageRoute(
                                 builder:
                                     (context) => LearningPage(email: widget.email, folderId: snapshot.data![index].id, usertype: widget.usertype)
                             ));
                            },
                            child :
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            height: 60,
                                            width: 402,
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlue,
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 1 , vertical: 1),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: const Icon(
                                                      Icons.article_outlined,
                                                      color: Colors.white,
                                                      size: 60,
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: [
                                                        Text(snapshot.data![index].activity_title.toString(),
                                                          style:const TextStyle(
                                                              letterSpacing: 1, fontWeight: FontWeight.bold,
                                                              fontSize: 12
                                                          ),
                                                        ),


                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const Icon(
                                                              Icons.date_range_outlined,
                                                              size: 9,
                                                            ),

                                                            const SizedBox(
                                                              width: 5,),

                                                           Text(
                                                                snapshot.data![index].created_date.toString(),
                                                                style: const TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),


                                                          ],
                                                        ),


                                                      ],

                                                    ),


                                                  ),


                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),

                          ),

                          )
                      );

                    }


                );

              }

            }
        )
    );

  }


  void showFolderDialog(){
    showDialog(context: context, builder: (_){
      return AlertDialog(
        content: addFolder(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    },);
  }

  Future addFolderActivity(String _activityTitle, String _courseId) async {
    var url = Api.addFolderActivity;
    var response = await http.post(Uri.parse(url), body: {
      "activity_title": _activityTitle,
      "course_id": _courseId,
    });

    var jsonBody = response.body;
    var result = json.decode(jsonBody);
    if (result == ResponseDB.successCode) {
      return ResponseDB.success;
    } else {
      return ResponseDB.Error;
    }
  }


  Widget addFolder(BuildContext context){
    Widget buildTextfield(String hint, TextEditingController controller){
      return Container(
        margin: const EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
              labelText: hint,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )
              )
          ),
          controller: controller,
        ),
      );
    }

    var foldernameController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(1),
      height: 150 ,
      width: 100,
      child: Column(
        children: [
          const Text('Add Activity Folder'),
          buildTextfield('FolderName', foldernameController),
          ElevatedButton(
              onPressed: (){
                activityList = [];
                setState(() {
                  addFolderActivity(foldernameController.text, widget.courseId);
                  Fluttertoast.showToast(msg: 'Folder Added Successfully');
                });

                Navigator.pop(context);

              },
              child: const Text('Add')
          ),
        ],
      ),
    );

  }

}






