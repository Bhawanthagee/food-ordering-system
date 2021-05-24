import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_mr_canteen/dialog_boxes/payment_confirm_dialog.dart';
import 'package:ds_mr_canteen/screens/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodOrderingPage extends StatefulWidget {


  const FoodOrderingPage({Key key, @required this.itemName, @required this.itemPrice, @required this.itemImage}) : super(key: key);
  final String itemName;
  final int itemPrice;
  final AssetImage itemImage;
  @override
  _FoodOrderingPageState createState() => _FoodOrderingPageState();
}

class _FoodOrderingPageState extends State<FoodOrderingPage> {

  DateTime timeNow = DateTime.now();
  String formattedTime, formattedDate;
  String count;
  final _key = GlobalKey<FormState>();
  final _fireStore = FirebaseFirestore.instance;
  final _realTimeDB = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             Container(
               margin: EdgeInsets.only(top: 20, ),
               height: 250,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: widget.itemImage,
                   fit: BoxFit.cover
                 )
               ),
             ),
              Container(
                height: 80,
                child: Center(
                  child: Text(
                    '${widget.itemName}',
                    style: TextStyle(
                      fontSize: 40
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Center(
                  child: Text(
                      'Rs.${widget.itemPrice}',
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                ),
              ),
              Form(
                key: _key,
                  child: Padding(
                    padding: const EdgeInsets.only(left:18.0,right: 18),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:  TextFormField(
                              onChanged: (value) {
                                count = value;
                              },
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return " field can not be emplty";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Count",
                                labelStyle: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade400),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    )),
                              )
                          ),),
                        SizedBox(width: 20,),
                        Expanded(
                            flex: 3,
                            child: Text('Please Enter The Amount',style: TextStyle(fontWeight: FontWeight.bold),))

                      ],
                    ),
                  )
              ),


              Padding(
                padding: const EdgeInsets.only(left:58.0,right: 58,top: 110),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {


                      if (_key.currentState.validate()){
                        uploadFirebase();

                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff5F67FF),
                                Color(0xff7e85ff),
                                Color(0xffbfc2ff),
                              ])),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            maxWidth: double.infinity, minHeight: 50),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }

  void uploadFirebase() async{
    DocumentSnapshot customerName = await _fireStore.collection('user_details').doc(loggedInUSer.email).get();
    String name = customerName['user_name'].toString();

    int countA = int.parse(count);
    int total =  widget.itemPrice * countA;

    formattedDate = DateFormat('dd-M-yyyy').format(timeNow);
    formattedTime = DateFormat('kk:mm').format(timeNow);
    _fireStore.collection('orders').doc('History').collection(loggedInUSer.email).add({
      'email':loggedInUSer.email,
      'name_of_the_customer' : name,
      'food_item' : widget.itemName,
      'total' :total,
      'amount':count,
      'date' : formattedDate,
      'time' : formattedTime

    });
    _realTimeDB.child('order').push().set({
      'email':loggedInUSer.email,
      'name_of_the_customer' : name,
      'food_item' : widget.itemName,
      'total' :total,
      'amount':count,
      'date' : formattedDate,
      'time' : formattedTime,
      'ustatus':'pending'
    });

    showDialog(context: context,
        builder: (BuildContext context){
          return PaymentBill(
            foodAmount:countA ,
            foodName: widget.itemName,
            pricePerItem : widget.itemPrice,
            totalPrice: total,


          );
        });

  }
}
