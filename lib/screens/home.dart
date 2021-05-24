import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_mr_canteen/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'food_ordering_page.dart';

User loggedInUSer;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUSer = user;
        print(loggedInUSer.email);
        print(loggedInUSer.uid);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _fireStore = FirebaseFirestore.instance;
  void onPressedFood(String name,String description, int price,AssetImage image ){
      print('$name $description $price ');
      print(loggedInUSer.email);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodOrderingPage(
        itemImage: image,
        itemName: name,
        itemPrice: price,


      )));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0, right: 10, left: 10.0),
          child: ListView(

            children: [
              GestureDetector(
                onTap:(){
                  onPressedFood('Chicken Fried Rice', 'i am the hunter', 150, AssetImage('assets/food/Frice.jpg'));
                },
                child: FoodCard(
                  foodName: 'Fried Rice',
                  price: 'Rs.250',
                  image: AssetImage('assets/food/Frice.jpg'),
                ),
              ),
              GestureDetector(
                onTap: (){
                  onPressedFood('Cutlet', 'this is a cutlet', 25, AssetImage('assets/food/cutlet.jpg'));

                },
                child: FoodCard(
                  foodName: 'Cutlet',
                  price: 'Rs.25',
                  image: AssetImage('assets/food/cutlet.jpg'),
                ),
              ),
              GestureDetector(
                onTap: (){
                  onPressedFood('Chicken Burger', 'this is a Chicken Burger', 150,  AssetImage('assets/food/burger.jpg'));
                },
                child: FoodCard(
                  foodName: 'Chicken Burger',
                  price: 'Rs.150',
                  image: AssetImage('assets/food/burger.jpg'),
                ),
              ),
              GestureDetector(
                onTap: (){
                  onPressedFood('Roll', 'this is a Roll',45,  AssetImage('assets/food/roll.jpg'));
                },
                child: FoodCard(
                  foodName: 'Roll',
                  price: 'Rs.45',
                  image: AssetImage('assets/food/roll.jpg'),
                ),
              ),
              GestureDetector(
                onTap: (){
                  onPressedFood('Fish Bun', 'this is a Fish Bun',35,  AssetImage('assets/food/fBun.jpg'));
                },
                child: FoodCard(
                  foodName: 'Fish Bun',
                  price: 'Rs.35',
                  image: AssetImage('assets/food/fBun.jpg'),
                ),
              ),
            ],
          ),
        ),

      )

    );
  }
}

class FoodCard extends StatelessWidget {

  final String foodName;
  final String price;
  final AssetImage image;
  final Color color;
  const FoodCard({Key key, this.foodName, this.price, this.image, this.color,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      height:180, width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFFe0c7ba),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
              child: Container(
                margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white70,
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover
              )

            ),
          )),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      decoration: BoxDecoration(
                          //color: Colors.greenAccent

                      ),
                      child: Text(foodName,style:GoogleFonts.anton(fontSize: 30,color: Colors.black) ,),
                    ),
                  ),Expanded(
                    flex: 1,
                    child: Container(

                      decoration: BoxDecoration(
                          //color: Colors.greenAccent

                      ),
                      child: Text(price,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black87)),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
      );
  }
}
