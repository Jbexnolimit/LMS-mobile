import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lms/api/api.dart';
import 'package:lms/model/get_profile.dart';
import 'package:lms/signup_screen.dart';


import 'admin/admin_dashboard.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends State<LoginScreen> {


  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();



  bool _isObscure = true;

  Future login() async {
  //  var url = "http://192.168.254.102/LMS/user_login.php";
    var url = Api.login_API;
    var response = await http.post(Uri.parse(url), body: {
      "email": email.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
        msg: "Login Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
        backgroundColor: Colors.black,
      );

      GetProfile(email: email.text).getProfile().then((value) {


        GetUserType(usertypeId: value[0]['usertype_id']).getUsertype().then((data) {

        print(value[0]['user_id']);

        if(data[0]['usertype'] == 1 || data[0]['usertype'] == '1') {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoard(
          fullname: value[0]['firstname'] + " " + value[0]['middlename'] + " " + value[0]['lastname'],
          email: email.text, userId: value[0]['user_id'], usertype: data[0]['usertype'],
          ),),);
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDashboard(
            fullname: value[0]['firstname'] + " " + value[0]['middlename'] + " " + value[0]['lastname'],
            email: email.text, userId: value[0]['user_id'], usertype: data[0]['usertype']
          ),),);
        }

                });

      });
      
      //makeLoginRequest();


    } else {
      Fluttertoast.showToast(msg: 'invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90)),
                    color: Color(0xFF42A5F5),
                    gradient: LinearGradient(
                      colors: [(Color(0xFF42A5F5)), Color(0xFF42A5F5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Image.asset(
                              "images/new.gif",
                              height: 90,
                              width: 90,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20, top: 20),
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
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
                  child: TextField(
                    controller: email,
                    cursorColor: const Color(0xffF5591F),
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xFF000000),
                      ),
                      hintText: "Enter Email",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xffEEEEEE),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: pass,
                    obscureText: _isObscure,
                    cursorColor: const Color(0xffF5591F),
                    decoration:  InputDecoration(
                      focusColor: const Color(0xffF5591F),
                      icon: const Icon(
                        Icons.vpn_key,
                        color: Color(0xFF000000),
                      ),
                      hintText: "Enter Password",
                        suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,

                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Write Click Listener Code Here
                    },
                    child: const Text("Forget Password?"),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    login();
                    // Write Click Listener Code Here.
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        (Color(0xFF42A5F5)),
                        Color(0xFF42A5F5)
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
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have Any Account?  "),
                      GestureDetector(
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                              color: Color(0xffF5591F)
                          ),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              )
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }

}
