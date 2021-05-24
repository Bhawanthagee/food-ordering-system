import 'package:ds_mr_canteen/constants.dart';
import 'package:ds_mr_canteen/dialog_boxes/loginErrors.dart';
import 'package:ds_mr_canteen/googleNavBar.dart';
import 'package:ds_mr_canteen/screens/home.dart';
import 'package:ds_mr_canteen/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
String password, email;
  final _key = GlobalKey<FormState>();

  void _submit ()async{
    try{
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if(user!=null){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
      }
    }on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found' || e.code == 'invalid-email'){
        showDialog(context: context,
            builder: (BuildContext context){
              return LoginErrorDialogEmail();
            });

      } else if(e.code == 'wrong-password'){
        showDialog(context: context,
            builder: (BuildContext context){
              return LoginErrorDialogPassword();
            });

      }
    }
  }

  @override
  Widget build(BuildContext context) {

    var medialQ = MediaQuery.of(context).size;

    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: medialQ.height*0.25,
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
                      Text('Welcome!',style: Constants.regularWhiteHeading,),
                      SizedBox(height: medialQ.height*0.03,),
                      Text('Login Here...',style: Constants.regularDarkText,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                          onChanged: (value) {
                            email = value;
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
                          )
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      //TODO password is here...................................................................................................
                      TextFormField(
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
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
                              _submit();
                            }

                          },
                          color: Color(0xFFff8940),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text('Login',style: Constants.regularDarkText,),
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                          print('registration clicked');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account?"
                            ),
                            Text(
                                "   Register",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                height:medialQ.height*0.25,
                width: double.infinity,

                decoration: BoxDecoration(

                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/log.png'
                        ),
                        fit: BoxFit.cover
                    )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
