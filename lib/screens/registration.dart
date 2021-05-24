import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_mr_canteen/constants.dart';
import 'package:ds_mr_canteen/dialog_boxes/registration_errors.dart';
import 'package:ds_mr_canteen/googleNavBar.dart';
import 'package:ds_mr_canteen/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'home.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  String _registerPassword, _registerEmail,confirmPassword,_registerName, _registerTelNo;
  bool showSpinner = false;
  double sizedBoxHeight = 20;
  final _key = GlobalKey<FormState>();
  bool _registerFormLoading;

  Future<String> _registerNewUSer()async{

    try{
      if(_registerPassword!=confirmPassword){
        return 'Password not Matched';
      }else{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _registerEmail, password: _registerPassword);
        await FirebaseFirestore.instance.collection('users').doc().set({
          'user_name':_registerName,
          'user_telly_phone' : _registerTelNo,
          'user_email' : _registerEmail,
          'role' : 'customer'

        });
        await FirebaseFirestore.instance.collection('user_details').doc(_registerEmail).set({
          'user_name':_registerName,
          'user_telly_phone' : _registerTelNo,
          'user_email' : _registerEmail,
          'role' : 'customer'
        });

        return null;
      }


    }on FirebaseAuthException catch (e){
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }else  if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      }
      return e.message;
    }
  }
  void _submitForm()async{
    String loginMsg = await _registerNewUSer();

    if(loginMsg!=null){
      showDialog(context: context,
          builder: (BuildContext context){
            return RegistrationErrors(text: '$loginMsg',);
          });
    }else{
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
    }
  }





  @override
  Widget build(BuildContext context) {

    var medialQ = MediaQuery.of(context).size;

    return  SafeArea(
      child: Scaffold(

          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: medialQ.height*0.20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFff8000),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:28.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome! ",style: Constants.regularWhiteHeading,),
                          SizedBox(height: medialQ.height*0.03,),
                          Text('Register Here...',style: Constants.regularDarkText,),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [

                          //TODO Name is here...................................................................................................
                          TextFormField(
                              //obscureText: true,
                              onChanged: (value) {
                                _registerName = value;
                              },
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return " Name can not be emplty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFff8000),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xFFff8000),
                                    )),
                              )),
                          SizedBox(
                            height: sizedBoxHeight,
                          ),
                          TextFormField(
                              //obscureText: true,
                              onChanged: (value) {
                                _registerTelNo = value;
                              },
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return " Mobile number can not be emplty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Tel. No",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFff8000),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xFFff8000),
                                    )),
                              )),
                          SizedBox(
                            height: sizedBoxHeight,
                          ),
                          TextFormField(
                              onChanged: (value) {
                                _registerEmail = value;
                              },
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return " Email can not be emplty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFff8000),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xFFff8000),
                                    )),
                              )),
                          SizedBox(
                            height: sizedBoxHeight,
                          ),
                          //TODO password is here...................................................................................................
                          TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                _registerPassword = value;
                              },
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return " Password can not be emplty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFff8000),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xFFff8000),
                                    )),
                              )),
                          SizedBox(
                            height: sizedBoxHeight,
                          ),
                          //TODO password is here...................................................................................................

                          TextFormField(
                              obscureText: true,
                              onChanged: (value) {
                                confirmPassword = value;
                              },
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return " Password can not be emplty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFff8000),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xFFff8000),
                                    )),
                              )),


                          SizedBox(height: 40,),
                          Container(
                            height: medialQ.height*0.065,
                            padding: EdgeInsets.only(top: 3,left: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  bottom: BorderSide(color: Colors.deepOrange),
                                  top: BorderSide(color: Colors.deepOrange),
                                  right: BorderSide(color: Colors.deepOrange),
                                  left: BorderSide(color: Colors.deepOrange),
                                )
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: (){
                                if(_key.currentState.validate()){
                                  if(mounted){
                                    setState(() {
                                      showSpinner = true;
                                    });
                                  }
                                  _submitForm();
                                  if(mounted){
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }
                                }

                              },
                              color: Color(0xFFff8940),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Text('Register',style: Constants.regularDarkText,),
                            ),
                          ),

                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
