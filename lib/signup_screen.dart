import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/api/api.dart';
import 'package:lms/verify.dart';

import 'api/response.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen>{



  TextEditingController firstname = TextEditingController();
  TextEditingController middlename = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController birthdate = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController compass = TextEditingController();

  String? selectedProvince,selectedMunicipality,selectedBarangay;
  List item_province = [], item_municipality = [], item_barangay = [];

  int radio_role = 1, radio_gender = 1;



  Future register() async {

    var url = Api.signup_API;
    var response = await http.post(Uri.parse(url), body: {
      "usertype": radio_role.toString(),

      "course": course.text,
      "province_code": selectedProvince.toString(),
      "municipality_code": selectedMunicipality.toString(),
      "barangay_code": selectedBarangay.toString(),

      "firstname": firstname.text,
      "middlename": middlename.text,
      "lastname": lastname.text,
      "email": email.text,
      "date_of_birth": birthdate.text,
      "gender": radio_gender.toString(),
      "contact_number": phonenumber.text,
      "password": pass.text,


    });



      var jsonBody = response.body;
      var data = json.decode(jsonBody);
      if (data == "Error") {
        Fluttertoast.showToast(
          msg: "User already exist!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
          backgroundColor: Colors.black,
        );
      } else {
        Fluttertoast.showToast(
            msg:'Registration Successful',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0,
            backgroundColor: Colors.black);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Steps_Verify(),),);
      }


  }



  void _handleRadioRoleValueChange(int? value) {
    setState(() {
      radio_role = value!;

      switch (radio_role) {
        case 0:
          break;
        case 1:
          break;

      }
    });
  }

  void _handleRadioGenderValueChange(int? value) {
    setState(() {
      radio_gender = value!;

      switch (radio_gender) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }



  Future getProvinces() async {
    var url = "http://192.168.51.59/LMS/province_ref.php";
    var response = await http.get(Uri.parse(url));
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      item_province = jsonData;
    });
    return "success";

  }


  Future getMunicipality() async {
    var url = "http://192.168.51.59/LMS/municipality_ref.php";
    var response = await http.post(Uri.parse(url), body: {
      "province_code": selectedProvince,});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
        item_municipality = jsonData;
    });

    return ResponseDB.success;

  }

  Future getBarangay() async {
    var url = "http://192.168.51.59/LMS/barangay_ref.php";
    var response = await http.post(Uri.parse(url), body: {
      "municipality_code": selectedMunicipality,});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      item_barangay = jsonData;
    });


    return "success";

  }




  @override
  void initState() {
    birthdate.text = ""; //set the initial value of text field
    super.initState();
    getProvinces();
   // getUsertypeId();
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
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(90)),
                      color: new Color(0xFF42A5F5),
                      gradient: LinearGradient(colors: [(new  Color(0xFF42A5F5)), new Color(0xFF42A5F5)],
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
                              margin: EdgeInsets.only(top: 50),
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
                                "Register",
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
                    margin: EdgeInsets.only(top: 20),
                    child: Stack(
                      // fit: StackFit.expand,
                      // overflow: Overflow.visible,
                        children:[
                          CircleAvatar(
                            backgroundImage: AssetImage("images/city.png"),
                            backgroundColor: Colors.white,
                            maxRadius: 50,
                          ),
                          Positioned(
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
                        ]
                    ),
                  ),


                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight:FontWeight.bold,
                          ),
                          text: 'ROLE : ',
                          children: <TextSpan>[
                            TextSpan(
                              text: String.fromCharCode(0xe2eb), //<-- charCode
                              style: TextStyle(
                                fontFamily: 'MaterialIcons', //<-- fontFamily
                                fontSize: 24.0,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: radio_role,
                        onChanged: _handleRadioRoleValueChange,

                      ),
                      const Text(
                        'LEARNER',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Radio(
                        value: 0,
                        groupValue: radio_role,
                        onChanged: _handleRadioRoleValueChange,
                      ),
                      const Text(
                        'FACILITATOR',
                        style: TextStyle(
                            fontSize: 16.0
                        ),
                      )
                    ],
                  ),



                  Container(

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
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight:FontWeight.bold,
                          ),
                          text: 'Personal Info : ',
                          children: <TextSpan>[
                            TextSpan(
                              text: String.fromCharCode(0xf816), //<-- charCode
                              style: const TextStyle(
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
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    child:  TextField(
                      controller: firstname,
                      cursorColor: const Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xFF000000),
                        ),
                        hintText: "First Name",
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
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child:  TextField(
                      controller: middlename,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Middle Name",
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
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child:  TextField(
                      controller: lastname,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Last Name",
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
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child:  TextField(
                      controller: email,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Email",
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
                      controller: course,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.web_rounded,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Course Code",
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
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child:TextField(
                      controller: birthdate,
                      cursorColor: Color(0xffF5591F),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Birth Date",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),

                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1980), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101)
                        );

                        if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            birthdate.text = formattedDate; //set output date to TextField value.
                          });

                        }else{
                          print("Date is not selected");
                        }
                      },

                    ),

                  ),
                  //set it true, so that user will not able to edit text


                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffEEEEEE),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: phonenumber,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        focusColor: Color(0xffF5591F),
                        icon: Icon(
                          Icons.phone,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Phone Number",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),


                  Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight:FontWeight.bold,
                          ),
                          text: 'Gender : ',
                          children: <TextSpan>[
                            TextSpan(
                              text: String.fromCharCode(0xe3c5), //<-- charCode
                              style: TextStyle(
                                fontFamily: 'MaterialIcons', //<-- fontFamily
                                fontSize: 24.0,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [

                      Radio(
                        value: 1,
                        groupValue: radio_gender,
                        onChanged: _handleRadioGenderValueChange,

                      ),
                      const Text(
                        'Male',
                        style: TextStyle(fontSize: 16.0),

                      ),
                      Radio(
                        value: 0,
                        groupValue: radio_gender,
                        onChanged: _handleRadioGenderValueChange,
                      ),
                      const Text(
                        'Female',
                        style: TextStyle(
                            fontSize: 16.0
                        ),
                      )
                    ],
                  ),

                  Container(

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
                          text: 'Address : ',
                          children: <TextSpan>[
                            TextSpan(
                              text: String.fromCharCode(0xe328), //<-- charCode
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


                            // /////////////////////
                  // //////////////// PROVINCE //////////////////////
                            // //////////////////////


                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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

                    child: DropdownButton(
                      hint: const Text("SELECT PROVINCE :" ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      isExpanded: true,
                      style: const TextStyle(
                        color: Colors.black,

                      ),
                      value: selectedProvince,
                         items: item_province.map((list){
                           return DropdownMenuItem(
                          child: Text(list['province']),
                          value: list['province_code'],
                           );
                                }).toList(),
                      onChanged: (value){
                        setState(() {

                          selectedProvince = value as String?;

                          print(selectedProvince);

                          selectedMunicipality = null;
                          item_municipality = [];

                          getMunicipality();
                        });
                      }
                    ),
                  ),



                  // ================ MUNICIPALITY ========================
                  // ======================================================
                  // ======================================================

                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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


                    child: DropdownButton(
                      hint: const Text("SELECT MUNICIPALITY :" ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      isExpanded: true,
                      style: TextStyle(
                        color: Colors.black,

                      ),
                      value: selectedMunicipality,
                      items: item_municipality.map((list){
                      return DropdownMenuItem(
                        child: Text(list['municipality']),
                        value: list['municipality_code'],
                      );
                    }).toList(),

                      onChanged: (value){
                        setState(() {


                          selectedMunicipality = value as String?;
                          print(selectedMunicipality);

                          selectedBarangay = null;
                          item_barangay = [];

                          getBarangay();

                        });
                      },
                    ),
                  ),


                  // =================== BARANGAY ====================
                  // =================================================
                  // =================================================


                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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


                    child: DropdownButton(
                      hint: const Text("SELECT BARANGAY :" ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      isExpanded: true,
                      style: TextStyle(
                        color: Colors.black,

                      ),
                      value: selectedBarangay,
                      items: item_barangay.map((list){
                        return DropdownMenuItem(
                          child: Text(list['barangay']),
                          value: list['barangay_code'],
                        );
                      }).toList(),

                      onChanged: (value){
                        setState(() {

                          selectedBarangay = value as String?;
                          print(selectedBarangay);

                        });
                      },
                    ),
                  ),



                  Container(

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
                          text: 'Password : ',
                          children: <TextSpan>[
                            TextSpan(
                              text: String.fromCharCode(0xe3b0), //<-- charCode
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
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffEEEEEE),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child:  TextField(
                      controller: pass,
                      obscureText: true,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        focusColor: Color(0xffF5591F),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Enter Password",
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
                      color: Color(0xffEEEEEE),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: compass,
                      obscureText: true,
                      cursorColor: Color(0xffF5591F),
                      decoration: InputDecoration(
                        focusColor: Color(0xffF5591F),
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color(0xFF000000),
                        ),
                        hintText: "Confirm Password",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      register();
                      // Write Click Listener Code Here.
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [(new  Color(0xFF42A5F5)), new Color(0xFF42A5F5)],
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
                        "REGISTER",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have Already Member?  "),
                        GestureDetector(
                          child: const Text(
                            "Login Now",
                            style: TextStyle(
                                color: Color(0xffF5591F)
                            ),
                          ),
                          onTap: () {
                            // Write Tap Code Here.
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )


                ]
            )

        )
    );
  }




}













