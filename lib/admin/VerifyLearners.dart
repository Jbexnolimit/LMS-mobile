

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/admin/verification_detail.dart';





class VerifyLearners extends StatefulWidget {
  const VerifyLearners({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();


}
class InitState extends State<VerifyLearners> {


  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
   return Scaffold(
     appBar: AppBar(
       title: const Text("VERIFY LEARNERS"),
       elevation: 0,
       backgroundColor: Color(0xFF29B6F6),
     ),
     body: Container(
       child: ListView.builder(

         itemCount: 5,
         itemBuilder: (_, index)
         {
           return Card(
             child: ListTile(
                 trailing: Icon(
                   Icons.arrow_forward_ios
                 ),
                 title: Text('FULL NAME #$index'),
                 subtitle: Text('EMAIL'),
                onTap: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => VerificationDetails(index)));
                } ,
             ),
           );

         },

       ),
     ),
   );
  }
}
