// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/services/firestore_services.dart';
import 'package:swift11/views/orders_screen/components/order_status.dart';
import 'package:swift11/views/orders_screen/order_place_details.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data,});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details ".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
      
            children: [
              orderStatus(color: redColor,icon: Icons.done,title: " placed",showDone: data['order_placed'],),
              orderStatus(color: Colors.blue,icon: Icons.thumb_up,title: "conformed",showDone: data['order_conformed'],),
              orderStatus(color: Colors.yellow,icon: Icons.car_crash,title: "On Delivery",showDone: data['order_on_delivery'],),
              orderStatus(color: redColor,icon: Icons.done_all,title: "Delivered",showDone: data['order_delivered'],),
      
      
              Divider(),
              10.heightBox,
      
           Column(
             children: [
               orderPlaceDetails(
                 d1: data['order_code'],
                 d2: data['shipping_methode'],
                 title1: "Order Code",
                 title2: "Shipping Methode",
               ),
               orderPlaceDetails(
                 d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
                 d2: data['payment_Method'],
                 title1: "Order Date",
                 title2: "Payment Methode",
               ),

               orderPlaceDetails(
                 d1: "Unpaid",
                 d2: "Order placed",
                 title1: "Payment status",
                 title2: "Delivery Status",
               ),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                 child: Row(

                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           "Shipping Address".text.fontFamily(semibold).make(),
                           "${data['order_by_name']}".text.make(),
                           "${data['order_by_email']}".text.make(),
                           "${data['order_by_address']}".text.make(),
                           "${data['order_by_city']}".text.make(),
                           "${data['order_by_state']}".text.make(),
                           "${data['order_by_phone']}".text.make(),
                           "${data['order_by_postalCode']}".text.make(),

                         ],
                       ),
                     ),
                     SizedBox(
                       width: 130,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           "Total amount ".text.size(10).fontFamily(semibold).make(),
                           "${data['total_amount']}".text.color(redColor).fontFamily(bold).make(),
                         ],
                       ),
                     ),

                   ],
                 ),
               )
             ],
           ).box.outerShadowMd.white.make(),
      
              10.heightBox,
              "Ordered Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  orderPlaceDetails(
                  title1: data['orders'][index]['title'],
                    title2:  data['orders'][index]['tprice'],
                    d1: "${ data['orders'][index]['qty']}x",
                    d2: "Refundable",),
      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: Color(data['orders'][index]['color'],),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.margin(EdgeInsets.only(bottom: 4.0)).white.make(),
              20.heightBox,
      
            ],
          ),
        ),
      )
    );
  }
}
