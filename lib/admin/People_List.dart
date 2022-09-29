

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Learners_det.dart';




class List_People extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => InitState();

  final int index;

  List_People(this.index);
}
class InitState extends State<List_People> {


  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PEOPLE"),
        elevation: 0,
        backgroundColor: Color(0xFF29B6F6),
      ),
      body: Container(
        child: ListView.builder(

          itemCount: 10,
          itemBuilder: (_, index)
          {
            return Card(
              child: ListTile(
                trailing: Icon(
                    Icons.arrow_forward_ios
                ),
                title: Text('NAME#$index'),
                subtitle: Text('EMAIL'),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearnersDet(index)));
                } ,
              ),
            );

          },

        ),
      ),
    );
  }
}
