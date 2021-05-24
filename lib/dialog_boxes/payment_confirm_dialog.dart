import 'package:ds_mr_canteen/constants.dart';
import 'package:ds_mr_canteen/constants/ConstantPaymentDialogBox.dart';
import 'package:flutter/material.dart';




class PaymentBill extends StatelessWidget {
  final String foodName;
  final int pricePerItem;
  final int totalPrice;
  final int foodAmount;

  const PaymentBill({Key key, this.foodName, this.totalPrice, this.foodAmount, this.pricePerItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    DateTime timeNow = DateTime.now();
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height:380,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('Done!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.green),),
                    SizedBox(height: 20,),
                    Text('"Your Order Has been Placed"', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
                    SizedBox(height: 40,),
                    Text('Order :    $foodName',style: PaymentDialogBoxConstant.billText,),
                    Text('Price of an item :    $pricePerItem',style: PaymentDialogBoxConstant.billText,),
                    Text('Order Amount :    $foodAmount',style: PaymentDialogBoxConstant.billText,),
                    Text('Total Price :    $totalPrice',style: PaymentDialogBoxConstant.billText,),

                    SizedBox(height: 25,),
                    RaisedButton(onPressed: () {
                      Navigator.pop(context);
                      print(timeNow);
                    },
                      color: Colors.blueAccent,
                      child: Text('Ok', style: TextStyle(color: Colors.white),),
                    ),


                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen,
                  radius: 60,
                  backgroundImage: AssetImage('assets/gifs/done.gif'),
                )
            ),
          ],
        )
    );
  }
}



class LoginErrorDialogEmail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    DateTime timeNow = DateTime.now();
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('OOOPS!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent),),
                    SizedBox(height: 20,),
                    Text('"Please Check the Email"', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),),

                    SizedBox(height: 15,),
                    RaisedButton(onPressed: () {
                      Navigator.pop(context);
                      print(timeNow);
                    },
                      color: Colors.blueAccent,
                      child: Text('Ok', style: TextStyle(color: Colors.white),),
                    ),


                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.lightGreen,
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/error.gif'),
                )
            ),
          ],
        )
    );
  }
}





