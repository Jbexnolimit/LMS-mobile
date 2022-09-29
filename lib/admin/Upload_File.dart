



import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class UploadFile extends StatefulWidget {
  const UploadFile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();


}

class InitState extends State<UploadFile> {

FilePickerResult? result;
String? _fileName;
PlatformFile? pickedfile;
bool isLoading = false;
File? fileToDisplay;

void pickFIle()async{
  try{
    setState(() {
      isLoading = true;
    });

    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','pdf','txt'],
      allowMultiple: false,
    );

    if(result != null){
      _fileName = result!.files.first.name;
      pickedfile = result!.files.first;
      fileToDisplay = File(pickedfile!.path.toString());

      print('File name $_fileName');
    }

    setState(() {
      isLoading = false;
    });
  }catch(e){
    print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

   initWidget() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: isLoading
            ? CircularProgressIndicator()
            :TextButton(onPressed: (){
              pickFIle();
            }, child: Text('Pick File')),
          ),
          if(pickedfile != null)
            SizedBox(
              height: 300,
              width: 400,
              child:  Image.file(fileToDisplay!,
              fit: BoxFit.fill,),
            )
        ],
      ),
    );
   }
}