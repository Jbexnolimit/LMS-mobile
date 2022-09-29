import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/comment.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;

import 'ViewFile.dart';
import 'api/api.dart';
import 'api/firebase_api.dart';
import 'api/response.dart';
import 'model/activity_model.dart';
import 'model/get_profile.dart';


class LearningPage extends StatefulWidget {

  final email;
  final folderId;
  final usertype;

   LearningPage({Key? key, required this.email, required this.folderId,required this.usertype}) : super(key: key);

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int numComments=0;

  File? file;
  List<PlatformFile>? _files;
  PlatformFile? pickedFile;
  Uint8List? bytes;
  String? _filename;
  late String filePath;
  late String localPath;
  String profile = "https://www.vectorstock.com/royalty-free-vector/graduate-student-flat-blue-simple-icon-with-long-vector-3247531";

  List<ActivityModel> activityList = [];


  bool isShow(String _usertype){
    if(_usertype=='0' || _usertype=="0"){
      return true;
    }else{
      return false;
    }
  }

  /*changeText() {
    setState(() {
        activityList = [];
      _filename = 'File name: '+_files!.first.path!.split('/').last;
    });

  }*/





  Future<void> openFileExplorer() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        withData: true,
        allowedExtensions: ['png','jpg','jpeg', 'pdf', 'docx']
    );

      if(result == null) return;
      final path = result.files.single.path!;

      setState(() => file = File(path));

  }


  Future<void> _openFileExplorer() async {
    _files = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        withData: true,
        allowedExtensions: ['png','jpg','jpeg', 'pdf', 'docx']
    ))!.files;
    print('Loaded file path is : ${_files!.first.path}');

    Uint8List? fileBytes = _files!.first.bytes;
    String base64file = base64Encode(fileBytes!);
    //changeText();
    print(base64file);
  }



  Future postActivity(String _folderId, String _title, String _description) async{
    var url = Api.uploadActivity;
    var response = await http.post(Uri.parse(url),
        body: {
          "activityfolder_id": _folderId,
          "activity_title": _title,
          "description": _description,
        });
    var jsonData = json.decode(response.body);
    if(jsonData=="error"){ //check error sent from server
      print("Error hahaha uploading hahaha");
      //if error return from server, show message from server
    }else {

      if (file == null) return;
      print(jsonData);
      print("activity uploaded successfully");
     // final fileName = file!.path.split('/').last;
      final destination = 'uploads/$jsonData';

      FirebaseApi.uploadFile(destination, file!);

    }

  }



  Future<void> _uploadActivity(String _folderId,String _title,String _description) async{

    var url = Api.uploadActivity;
    Uint8List? fileBytes = _files!.first.bytes;
    String base64file = base64Encode(fileBytes!);
   // var filepath = _files!.first.path;
    String filename = _files!.first.path!.split('/').last;
    String? mimeType = mime(filename);

    print("Base64String = " +base64file);


    var response = await http.post(Uri.parse(url),
        body: {
          "activityfolder_id": _folderId,
          "activity_title": _title,
          "description": _description,
          "learning_file": base64file,
          "learningfile_name": filename,
          "mime": mimeType,
    });

    print(response.body);

    var jsonData = json.decode(response.body);
    if(jsonData=="error"){ //check error sent from server
      print("Error hahaha uploading hahaha");
      //if error return from server, show message from server
    }else{
      print("Upload successful!");
    }

  }



  void showAddActivityDialog(){
    showDialog(context: context, builder: (_){
      return AlertDialog(
        content: addActivity(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    },);
  }





  Future<List<ActivityModel>> getActivity(String _folderId) async{

    var url = Api.activities_API;
    final response = await http.post(Uri.parse(url), body: {
      "activityfolder_id" : _folderId,
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    if(response.statusCode == ResponseDB.successCode){
      for(Map<String, dynamic> i in jsonData){
        activityList.add(ActivityModel.fromJson(i));
      }
      return activityList;

    }else{
      return activityList;
    }

  }

  Future getNumComments(String _activityId) async{
    var url = Api.getComments_API;
    var response = await http.post(Uri.parse(url), body: {
      "activity_id" : _activityId,
    });
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    return  jsonData.length.toString();

  }

 /* Future getFiles(String _learningfile_id) async{
    var url = "http://localhost/LMS/view_file.php";
    var response = await http.post(Uri.parse(url), body: {
      "learningfile_id" : _learningfile_id,
    });
    return jsonDecode(response.body);
  }*/

 /* Future getFileName(String _activityId) async{
    var url = "http://localhost/LMS/get_file_name.php";
    var response = await http.post(Uri.parse(url), body: {
      "activity_id" : _activityId,
    });
    return jsonDecode(response.body);
  }*/


  Widget addActivity(BuildContext context){

    final filename = file != null ?  "File name :  "+file!.path!.split('/').last : 'File name :  No file selected';

    Widget buildTextfield(String hint, TextEditingController controller){
      return Container(
        margin: const EdgeInsets.all(2),
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

    var activityTitleController = TextEditingController();
    var activityDesctiptionController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(1),
      height: 350 ,
      width: 150,
      child: Column(
        children: [
          const Text('Add Activity'),
          Divider(),
          buildTextfield('Activity Title', activityTitleController),
          Divider(),
          buildTextfield('Activity Description', activityDesctiptionController),

              Divider(),

             Align(
            alignment: Alignment.topLeft,
            child: Text(filename),
          ),



        Container(
            padding: const EdgeInsets.only(top: 20),
            child:  MaterialButton(
                color: Colors.amber[300],
                child: const Text('Pick File'),
                onPressed: () {
                  //_openFileExplorer();
                  _openFileExplorer();
                }
            ),
        ),


          ElevatedButton(
              onPressed: (){
                activityList = [];
                setState(() {
                 _uploadActivity(widget.folderId,activityTitleController.text,activityDesctiptionController.text);
                //  postActivity(widget.folderId,activityTitleController.text,activityDesctiptionController.text);
                  Fluttertoast.showToast(msg: 'Learning Activity uploaded successfully!');
                });
                Navigator.pop(context);
              },
              child: const Text('Add')
          ),
        ],
      ),
    );

  }



  Widget Activity(){

      return FutureBuilder(
        // initialData: const Text('No Activities'),
        future: getActivity(widget.folderId),
    builder: (context, AsyncSnapshot<List<ActivityModel>> snapshot){

    if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
    }

    if(snapshot.hasError &&
    !snapshot.hasData){
    print('No activities: ${snapshot.data}');

    return const  CircularProgressIndicator();

    }else {

    return ListView.builder(
        shrinkWrap: true,
        itemCount: activityList.length,
        itemBuilder: (context, index) {
      return
        Card(child:
      Padding(padding:
      EdgeInsets.all(10.0),
        child:
        Column(
          children: [
            Row(children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("images/user_icon.png"),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Text("Jonard", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),),
                  Text(snapshot.data![index].created_date.toString()),

                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
            ),
            Divider(),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Activity Title: " +snapshot.data![index].activity_title.toString(),
                  style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),),
            ),
            SizedBox(),
            Divider(),
            Align(
              alignment: Alignment.topLeft,
              child: Text("\n" +snapshot.data![index].description.toString()),
            ),
            Divider(),

            Padding(
              child: InkWell(
                onTap: (){

                  /*  print(snapshot.data![index].learning_filename);
                    print(snapshot.data![index].mime);
                    print(snapshot.data![index].learning_file);*/

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                        ViewFile(learningfile_id: snapshot.data![index].learningfile_id, filename: snapshot.data![index].learning_filename,
                            mime: snapshot.data![index].mime, file: snapshot.data![index].learning_file)
                      ),
                    );
                },
              child:
              Row(children: [
                Icon(Icons.attachment_outlined,
                ),
                Text(" "+snapshot.data![index].learning_filename+"."+snapshot.data![index].mime),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              ),
              padding: EdgeInsets.all(15.0),
            ),

            Divider(),

            // Image.network(imageUrl),
            Padding(child:
            Row(children: [
              ElevatedButton.icon(
                onPressed: () {

                  GetProfile(email: widget.email).getProfile().then((value) {

                    print(widget.email);
                    print(snapshot.data![index].id);
                    print(value[0]['user_id']);

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Comment(usertype: widget.usertype,email: widget.email, activityId: snapshot.data![index].id, userId: value[0]['user_id'],)),
                      );

                  });

                },
                icon: Icon(Icons.comment, size: 16),
                label: const Text("Comment"),
              ),
            ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
              padding: EdgeInsets.all(5.0),
            ),
            Text("getNumComments(snapshot.data![index].id).toString()")

          ],
        ),
        ),
      );
          }

      );
     }
    }
    );
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  initWidget();
  }

  initWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning Page"),
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
              { showAddActivityDialog(); },
              icon: Icon(Icons.add_circle_outline),
              iconSize: 30,
            ),
          )
        ] ,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:
    SingleChildScrollView(
    child :
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Activity(),
              Divider(),
              Divider(),
            ],
           ),
        ),
    );
  }
}





