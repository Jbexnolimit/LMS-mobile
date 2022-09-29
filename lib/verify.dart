

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';


class Steps_Verify extends StatefulWidget{
  const Steps_Verify({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => InitState();

}
class InitState extends State<Steps_Verify> {

  int activeStepIndex = 0;
  String verify = "Please Check your email and click the link to verify";
  String sent = "Verification has been sent! Check your email and verify now!";

  File? _image;
  final picker = ImagePicker();



  Future getImage() async {
    final image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if(image != null){
        _image = File(image.path);
      }else{
        print('No Image');
      }
    });
  }





  List<Step> steplist() =>[

    Step(
        state: activeStepIndex <= 0 ?StepState.editing
            :StepState.complete,
        isActive: activeStepIndex >= 0,
        title:  const Text('Step 1'),
        subtitle: const Text('Email Verification'),
        content: Column(
          children: [
            const Text('Email Verification for:'),
            const Text('pitokbatolata@gmail.com'),

            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text('Click send button to verify your email'),
            ),

        Container(
            padding: EdgeInsets.only(top: 30),
          child:  MaterialButton(
            color: Colors.amber[300],
            child: Text('Verify Email'),
            onPressed: () {
              /* verify(verifylink).then(
                  (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              ),
            );
            setState(() {
              verifyButton = false;
            });*/
            },
          ),
        )

          ],

        )
    ),

    Step(
        state: activeStepIndex <= 1 ?StepState.editing
            :StepState.complete,
        isActive: activeStepIndex >= 1,
        title:  const Text('Step 2'),
        subtitle: const Text('Identity Verification'),
        content:Column(
            children: [

              Center(
                child:_image == null ? const Text("data") :
                Image.file(_image!),
              ),


              GestureDetector(
                onTap: () {
                  getImage();
                  // Write Click Listener Code Here.
                },
                child:Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 120, right: 120, top: 70),
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
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: const Text(
                    "Camera",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ]
        )
    ),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('stepper'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: activeStepIndex,
        steps: steplist(),
        onStepContinue: (){
          if(activeStepIndex <(steplist().length-1)){
            activeStepIndex +=1;
          }
          setState(() {

          });
        },
        onStepCancel: (){
          if( activeStepIndex == 0){
            return;
          }
          activeStepIndex -=1;
          setState(() {

          });
        },
      ),
    );
  }

}