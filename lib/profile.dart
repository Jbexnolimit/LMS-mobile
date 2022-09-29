import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
import 'model/get_profile.dart';


class ProfilePage extends StatefulWidget {
  final fullname;
  final email;

  ProfilePage({required this.email,required this.fullname });
  //const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   String? course_Id;
   TextEditingController pass = TextEditingController();
   TextEditingController compass = TextEditingController();
   final GlobalKey<FormState> formkey = GlobalKey<FormState>();

   File? _image;
   final picker = ImagePicker();
   bool invisiblePassword = true;
   bool invisiblePassword1 = true;

   void getProfile() {

    GetProfile(email: widget.email).getProfile().then((value) {


      course_Id = value[0]['course_id'].toString();

    });

    print(widget.email);
    print("course id: " +course_Id!);

  }

   Future getImage() async {
     final image = await picker.pickImage(source: ImageSource.gallery);

     setState(() {
       if(image != null){
         _image = File(image.path);
       }else{
         print('No Image');
       }
     });
   }

   @override
   void initState() {
     invisiblePassword = false;
     super.initState();

   }


   @override
  Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(
           title: const Text("PROFILE"),
           backgroundColor: Colors.lightBlueAccent,
         ),
         body:Form(
             key: formkey,
             child:ListView(

               children: <Widget>[


                 Container(
                   margin: EdgeInsets.only(top: 25),
                   child:CircleAvatar(
                     backgroundColor: Colors.grey,
                     radius: 78,
                     child: CircleAvatar(
                       backgroundColor: Colors.white,
                       radius: 75,
                       backgroundImage: _image == null
                           ? null :
                       FileImage(_image!),

                       child: GestureDetector(
                           onTap: (){
                             getImage();
                           },
                           child:Container(

                             alignment: Alignment.bottomRight,
                             child:CircleAvatar(
                                 radius: 17,
                                 backgroundColor: Colors.grey,
                                 child: CircleAvatar(
                                   backgroundColor: Colors.white,
                                   radius: 15,
                                   child: Icon(Icons.edit,
                                     color: Colors.black,),
                                 )
                             ),
                           )
                       ),
                     ),
                   ),
                 ),

                 GestureDetector(
                   onTap: (){

                   },
                   child:Container(
                     alignment: Alignment.center,
                     margin: EdgeInsets.only(left: 153, right: 153, top: 5),
                     padding: EdgeInsets.only(left: 20, right: 20),
                     height: 25,
                     decoration: BoxDecoration(
                       gradient: LinearGradient(colors: [
                         (new Color(0xFF42A5F5)),
                         new Color(0xFF42A5F5)
                       ],
                           begin: Alignment.centerLeft,
                           end: Alignment.centerRight
                       ),
                       borderRadius: BorderRadius.circular(50),
                       color: Colors.grey[200],
                       boxShadow: [
                         BoxShadow(
                             offset: Offset(0, 10),
                             blurRadius: 50,
                             color: Color(0xffEEEEEE)
                         ),
                       ],
                     ),
                     child: Text(
                       "Upload",
                       style: TextStyle(
                           color: Colors.white
                       ),
                     ),
                   ),
                 ),

                 Card(
                   margin: EdgeInsets.only(top: 20),
                   child: Column(
                     children: <Widget>[
                       const Text("User Information" , style:  TextStyle(
                         fontSize: 20,
                         color: Colors.black
                         ,fontWeight:FontWeight.bold,
                       ),
                       ),

                       const Divider(),

                       Container(
                         alignment: Alignment.centerLeft,
                         margin: EdgeInsets.only(left: 20, top: 10),

                         child:Text(widget.fullname,
                           style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,)  ,),

                       ),
                       Container(
                         alignment: Alignment.centerLeft,
                         margin: EdgeInsets.only(left: 20, top: 15),
                         child:Text(widget.email,
                             style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,)),
                       ),

                       const Divider(),

                       const ListTile(title: Text("Course",style: TextStyle(fontWeight:FontWeight.bold,),),
                         subtitle: Text("Backend Programming"),
                         leading: Icon(Icons.computer_sharp,color: Color(0xFF000000),),
                       ),

                       const Divider(),

                       ExpansionTile(
                         textColor: Colors.black,
                         collapsedTextColor: Colors.black,
                         title: Text('Change Password',
                           style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                         children: <Widget>[

                           TextFormField(
                             controller: pass,
                             obscureText: !invisiblePassword,
                             cursorColor: Color(0xffF5591F),
                             validator: (String? value){
                               if(value!.isEmpty){
                                 return "Please enter password";
                               }
                               if(pass.text != compass.text){
                                 return "Password Not Match";
                               }
                               return null;
                             },

                             decoration: InputDecoration(
                               icon: Icon(
                                 Icons.vpn_key,
                                 color: Color(0xFF000000),
                               ),
                               suffixIcon: IconButton(
                                 icon:Icon(
                                   invisiblePassword ?
                                   Icons.visibility :
                                   Icons.visibility_off,
                                   color: Color(0xFF000000),
                                 ), onPressed: () {
                                 setState(() {
                                   invisiblePassword = !invisiblePassword;
                                 });

                               },
                               ),
                               hintText: "New Password",
                               enabledBorder: InputBorder.none,
                               focusedBorder: InputBorder.none,
                             ),

                           ),

                           TextFormField(
                             controller: compass,
                             obscureText: !invisiblePassword1,
                             cursorColor: Color(0xffF5591F),
                             validator: (String? value){
                               if(value!.isEmpty){
                                 return "Please enter password";
                               }
                               if(pass.text != compass.text){
                                 return "Password Not Match";
                               }
                               return null;

                             },
                             decoration: InputDecoration(
                               icon: Icon(
                                 Icons.vpn_key,
                                 color: Color(0xFF000000),
                               ),
                               suffixIcon: IconButton(
                                 icon:Icon(
                                   invisiblePassword1 ?
                                   Icons.visibility :
                                   Icons.visibility_off,
                                   color: Color(0xFF000000),
                                 ), onPressed: () {
                                 setState(() {
                                   invisiblePassword1 = !invisiblePassword1;
                                 });

                               },
                               ),
                               hintText: "Comfirm Password",
                               enabledBorder: InputBorder.none,
                               focusedBorder: InputBorder.none,
                             ),
                           ),

                           GestureDetector(
                             onTap: (){
                               if(formkey.currentState!.validate()){
                                 return;
                               }else{
                                 print("Unsuccessful");
                               }

                             },

                             child:Container(
                               alignment: Alignment.center,
                               margin: EdgeInsets.only(left: 150, right: 150, top: 5),
                               padding: EdgeInsets.only(left: 20, right: 20),
                               height: 25,
                               decoration: BoxDecoration(
                                 gradient: LinearGradient(colors: [
                                   (new Color(0xFF42A5F5)),
                                   new Color(0xFF42A5F5)
                                 ],
                                     begin: Alignment.centerLeft,
                                     end: Alignment.centerRight
                                 ),
                                 borderRadius: BorderRadius.circular(50),
                                 color: Colors.grey[200],
                                 boxShadow: [
                                   BoxShadow(
                                       offset: Offset(0, 10),
                                       blurRadius: 50,
                                       color: Color(0xffEEEEEE)
                                   ),
                                 ],
                               ),
                               child: Text(
                                 "Change",
                                 style: TextStyle(
                                     color: Colors.white
                                 ),
                               ),
                             ),
                           )

                         ],
                       ),


                     ],
                   ),
                 )
               ],
             )
         )

     );

  }
}



