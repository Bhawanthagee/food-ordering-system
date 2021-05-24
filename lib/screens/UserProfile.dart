import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_mr_canteen/constants.dart';
import 'package:ds_mr_canteen/screens/home.dart';
import 'package:ds_mr_canteen/screens/login.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _fireStore = FirebaseFirestore.instance;
  String name, tele,role;

void getUserName()async{
  DocumentSnapshot data = await _fireStore.collection('user_details').doc(loggedInUSer.email).get();
  String fireName = data['user_name'].toString();
  String fireTele = data['user_telly_phone'].toString();
  String fireRole = data['role'].toString();

  setState(() {
    name =fireName;
    tele = fireTele;
    role = fireRole;
  });

}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight:Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: Colors.blueAccent
                  ),
                  child:Column(
                    children: [
                      Container(
                        height: 80,width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile.png')
                          )
                        ),
                      ),
                      Container(
                        height: 50,width: double.infinity,
                        color: Colors.deepOrange,
                        child: Center(child: Text("Hello",style: TextStyle(fontSize: 40),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top :28.0),
                        child: Text('$name',style: TextStyle(fontSize: 25,color: Colors.white)),
                      )
                    ],
                  ),
                ),


                ),

            Expanded(
              flex: 4,
                child:Padding(
                  padding: const EdgeInsets.only(left:18.0,top: 30),
                  child: Container(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name : ',style:TextStyle(fontSize: 20)),
                        Text('$name'),
                        SizedBox(height: 30,),
                        Text('Tele Phone Number: ',style:TextStyle(fontSize: 20)),
                        Text('$tele'),
                        SizedBox(height: 25,),
                        Text('Your are a $role of the system'),
                        SizedBox(height: 80,),
                        Center(
                          child: RaisedButton(
                              child: Text('Log Out'),
                              onPressed:(){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          }

                          ),
                        ),

                      ],
                    ),

            ),
                ),
            ),
          ],
        )
      ),
    );
  }
}
