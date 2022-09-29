import 'package:avatar_view/avatar_view.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api/api.dart';
import 'api/response.dart';


class Comment extends StatefulWidget {
  final email;
  final userId;
  final activityId;
  final usertype;
  const Comment({Key? key, required this.email, required this.activityId, required this.userId, required this.usertype}) : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();


  bool isShow(String _usertype){
    if(_usertype=='0' || _usertype=="0"){
      return true;
    }else{
      return false;
    }
  }



  Widget commentChild() {

    return FutureBuilder(
        // initialData: const Text('No Activities'),
        future: getComment(widget.activityId),
    builder: (context, AsyncSnapshot snapshot){

    if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
    }

    if(snapshot.hasError &&
    !snapshot.hasData){
    print('activities snapshot data is: ${snapshot.data}');
    return const Center(child: Text("No Comments"));
    }else {

    return ListView.builder(
    shrinkWrap: true,
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
     return
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:  BorderRadius.all(Radius.circular(50))),
                  child: AvatarView(
                    radius: 60,
                    borderColor: Colors.yellow,
                    avatarType: AvatarType.CIRCLE,
                    backgroundColor: Colors.red,
                    imagePath: "images/user_icon.png",
                    placeHolder: Container(
                      child: Icon(Icons.person, size: 50,),
                    ),
                    errorWidget: Container(
                      child: Icon(Icons.error, size: 50,),
                    ),
                  ),
                ),
              ),
              title:
                      Text(snapshot.data![index]['firstname']+" "+snapshot.data![index]['middlename']+" "+snapshot.data![index]['lastname'],
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                trailing:
                Visibility(
                  visible: isShow(widget.usertype), 
                  child: IconButton(
                icon: Icon(Icons.delete),
                iconSize: 24.0,
                color: Colors.black,
                onPressed: (){},
              ),
            ),
              subtitle: Text(snapshot.data![index]['comment']),
            ),
          );
       }  
      );
    }
        }
    );
  }


  Future getComment(String _activityId) async{
    var url = Api.getComments_API;
    var response = await http.post(Uri.parse(url), body: {
      "activity_id" : _activityId,
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    if(response.statusCode == ResponseDB.successCode){


      return jsonData;

    }else{
      return ResponseDB.Error;
    }

  }

  Future postComment() async{
    var url = Api.postComment_API;
    var response = await http.post(Uri.parse(url), body: {
      "comment": commentController.text,
      "user_id": widget.userId,
      "activity_id": widget.activityId,
    });


    var jsonBody = response.body;
    var result = json.decode(jsonBody);
    if(result == ResponseDB.successCode){

      return ResponseDB.success;

    }else{
      return ResponseDB.Error;
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:
      Container(
        child: CommentBox(
          userImage: "images/user_icon.png",
          child: commentChild(),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);

              postComment();
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.lightBlueAccent,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}