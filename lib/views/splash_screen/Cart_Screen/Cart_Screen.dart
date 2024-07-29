// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift11/Home_controller/cart_controller.dart';
import 'package:swift11/Widgets_common/Our_button.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/loadingIndicator.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/services/firestore_services.dart';
import 'package:swift11/views/splash_screen/Cart_Screen/shipping_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: ourButton(
          color: Colors.red,
          onPress: () {
            Get.to(()=>ShippinDetails());
          },
          textColor: whiteColor,
          title: "Proceed to shipping"),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart "
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
          stream: FirestorServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is Empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);

              controller.productSnapshot = data;


              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network('${data[index]['img']}',
                              width: 80,
                                fit: BoxFit.cover,
                              ),
                              title: "${data[index]['title']} (x ${data[index]['qty']})"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                              subtitle: "${data[index]['tprice']}"
                                  .numCurrency
                                  .text
                                  .size(14)
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make(),
                              trailing: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ).onTap(() {
                                FirestorServices.deleteDocument(data[index].id);
                              }),
                            );
                          }),
                    )),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price "
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(() => "${controller.totalp.value} "
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make()),
                      ],
                    )
                        .box
                        .padding(EdgeInsets.all(12))
                        .width(context.screenWidth - 60)
                        .color(Colors.amber.shade100)
                        .roundedSM
                        .make(),
                    10.heightBox,
                    // SizedBox(
                    //   width: context.screenWidth - 60,
                    //   child: ourButton(
                    //       color: Colors.red,
                    //       onPress: () {},
                    //       textColor: whiteColor,
                    //       title: "Proceed to shipping"),
                    // )
                  ],
                ),
              );
            }
          }),
    );
  }
}
