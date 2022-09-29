import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class LearningPortal extends StatefulWidget{
  const LearningPortal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LearningPortal>{

  Future getActivities() async{

    var url = "http://localhost/LMS/activities.php";
    var response = await http.get(Uri.parse(url));
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    return jsonData;

  }

  /*Future getUserData() async{
    var url = "http://localhost/LMS/user_session.php";
    var response = await http.get(Uri.parse(url));
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    print(jsonData.toString());

  }*/




  @override
  Widget build(BuildContext context) {
   // getUserData();
    return initWidget();
  }

  Widget initWidget() {

    return Scaffold(
      appBar: AppBar(
        title: const Text('LEARNING PORTAL'),
        backgroundColor: Colors.green,

      ),

      backgroundColor: Colors.grey[100],
        body:
          FutureBuilder(
        //  initialData: Text('No Activity'),
        future: getActivities(),
        builder: (context, AsyncSnapshot snapshot){


            if(snapshot.hasError) print(snapshot.error);

            return snapshot.hasData? ListView.builder(


                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  List list = snapshot.data;


                  return ListTile(
                    title: Text(list[index]['activity_title'],

                      textAlign: TextAlign.start,
                      style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),

                    ),

                      onTap: () {

                        Fluttertoast.showToast(msg: list[index]['activity_title']);

                        setState(() {

                        });

                      },
                  );

               }
               )
                : const Center(child: CircularProgressIndicator(),
            );
        }
      )
    );
  }
}
