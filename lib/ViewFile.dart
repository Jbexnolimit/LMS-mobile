


import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';




class ViewFile extends StatefulWidget {

  final learningfile_id;
  final filename;
  final mime;
  final file;

  ViewFile({Key? key, required this.learningfile_id, required this.filename, required this.mime, required this.file}) : super(key: key);

  @override
  _ViewFileState createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> {



    _createFileFromString(String _file) async {
    Uint8List bytes = base64.decode(_file);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File( "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path;
    }

  showFile(String _file){
      print(base64Decode(_file));
      return Image.memory(base64Decode(_file),width: 400,height: 400);
  }


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boxfit Cover"),
        backgroundColor: Color(0XFF0CBBEC),
      ),
      body:
      Center(
         child:
             widget.file != null &&
         widget.mime == "image/jpeg" || widget.mime == "image/png" ?
         Card(
           child:
           showFile(widget.file)
         ) : Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:
                   _createFileFromString(widget.file).then((path)=>OpenFile.open(path))
               ),
             ),
      )

    );
  }
}
