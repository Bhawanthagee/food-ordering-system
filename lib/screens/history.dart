import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_mr_canteen/screens/home.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final _fireStore = FirebaseFirestore.instance;


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: SingleChildScrollView(
        child: Container(

          child: Center(
            child: StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('orders').doc('History').collection(loggedInUSer.email).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                {
                  final foods = snapshot.data.docs;
                  List <FoodBubble>foodWidgets = [];
                  for (var food in foods){
                    final foodName = food.data()['food_item'];
                    final foodAmount = food.data()['amount'];
                    final orderDate = food.data()['date'];
                    final orderTime = food.data()['time'];


                    final foodWidget = FoodBubble(
                      name: foodName,
                      time: orderTime,
                      date: orderDate,
                      amount: foodAmount,

                    );
                    foodWidgets.add(foodWidget);
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    child: Column(
                      children: foodWidgets,
                    ),
                  );

                }
                //return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}class FoodBubble extends StatelessWidget {
  final String name;
  final String amount;
  final String date;
  final String time;

  const FoodBubble({Key key, this.name, this.amount, this.date, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Material(
            elevation: 2.0,
            color:Color(0xFFfffbf5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal:100),
              child: Text(

                'amount: $amount \nDate: $date \nTime: $time',
                style: TextStyle(
                    fontSize: 16
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

