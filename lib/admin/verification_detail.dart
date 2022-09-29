
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerificationDetails extends StatelessWidget{

  late final int index;

  VerificationDetails(this.index);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("LEARNERS DETAILS"),
       elevation: 0,
       backgroundColor: Color(0xFF29B6F6),
     ),
     body:SingleChildScrollView(
       child: Column(
         children: [
           Container(
             alignment: Alignment.center,
             margin: EdgeInsets.only(top: 20),
             child: Stack(
               // fit: StackFit.expand,
               // overflow: Overflow.visible,
                 children:[
                   Image.asset(
                     'images/city.png',
                     width: 200,
                     height: 200,
                     fit: BoxFit.contain,

                     //backgroundImage: AssetImage("images/city.png"),
                     //backgroundColor: Colors.white,
                    // maxRadius: 50,


                   ),
                  /* Positioned(
                     right: -8,
                     bottom: 0,
                     child:SizedBox(
                       height: 40,
                       width: 40,
                       child: FlatButton(
                         padding: EdgeInsets.zero,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(100),
                           side: BorderSide(color: Colors.white),
                         ),
                         color: Color(0xFFF5F6F9),
                         onPressed: (){},
                         child: SvgPicture.asset("images/Camera Icon.svg"),
                       ),
                     ),
                   )
                     */
                 ]
             ),
           ),

           Container(
               height: 50,
               alignment: Alignment.bottomLeft,
               margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
               padding: const EdgeInsets.only(left: 20, right: 20),

               // child :Text("Address",maxLines: 20,
               //  style: TextStyle(fontSize: 20.0 ,
               // fontWeight:FontWeight.bold,
               //  color: Colors.black ,),
               //  )
               child: RichText(
                 text: TextSpan(
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 20.0,
                     fontWeight:FontWeight.bold,
                   ),
                   text: 'INFORMATION : ',
                   children: <TextSpan>[
                     TextSpan(
                       text: String.fromCharCode(0xf816), //<-- charCode
                       style: TextStyle(
                         fontFamily: 'MaterialIcons', //<-- fontFamily
                         fontSize: 24.0,
                         color: Colors.black,
                       ),
                     )
                   ],
                 ),
               )
           ),


           Container(

               alignment: Alignment.bottomLeft,
               margin: const EdgeInsets.only( right: 20, top: 20),
               padding: const EdgeInsets.only(left: 10, right: 20),

                child :Text("FULL NAME :",maxLines: 20,
                 style: TextStyle(fontSize: 17.0 ,
                 color: Colors.black ,),
                )

           ),

           Container(

               alignment: Alignment.topLeft,
               margin: const EdgeInsets.only( right: 20, top: 20),
               padding: const EdgeInsets.only(left: 10, right: 20),

               child :Text("DARI IYANG NAME I BUTANG",maxLines: 20,
                 style: TextStyle(fontSize: 17.0 ,
                   color: Colors.black ,),
               ),

           ),
           Divider( thickness: 1,),
           Container(

               alignment: Alignment.bottomLeft,
               margin: const EdgeInsets.only( right: 20, top: 20),
               padding: const EdgeInsets.only(left: 10, right: 20),

               child :Text("EMAIL :",maxLines: 20,
                 style: TextStyle(fontSize: 17.0 ,
                   color: Colors.black ,),
               )

           ),

           Container(

             alignment: Alignment.topLeft,
             margin: const EdgeInsets.only( right: 20, top: 20),
             padding: const EdgeInsets.only(left: 10, right: 20),

             child :Text("DARI IYANG EMAIL I BUTANG",maxLines: 20,
               style: TextStyle(fontSize: 17.0 ,
                 color: Colors.black ,),
             ),

           ),
           Divider( thickness: 1,),
           Container(

               alignment: Alignment.bottomLeft,
               margin: const EdgeInsets.only( right: 20, top: 20),
               padding: const EdgeInsets.only(left: 10, right: 20),

               child :Text("COURSE :",maxLines: 20,
                 style: TextStyle(fontSize: 17.0 ,
                   color: Colors.black ,),
               )

           ),

           Container(

             alignment: Alignment.topLeft,
             margin: const EdgeInsets.only( right: 20, top: 20),
             padding: const EdgeInsets.only(left: 10, right: 20),

             child :Text("DARI IYANG COURSE I BUTANG",maxLines: 20,
               style: TextStyle(fontSize: 17.0 ,
                 color: Colors.black ,),
             ),

           ),
           Divider( thickness: 1,),

            Container(
             alignment: Alignment.center,
             margin: EdgeInsets.only(left: 20, right: 20, top: 70),
             padding: EdgeInsets.only(left: 20, right: 20),
             height: 54,
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
               "VERIFY",
               style: TextStyle(
                   color: Colors.white
               ),
             ),
           ),
         ],
       ),
     )

   );
  }

}