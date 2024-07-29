import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swift11/Home_controller/cart_controller.dart';
import 'package:swift11/Widgets_common/Our_button.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/lists.dart';
import 'package:swift11/consts/loadingIndicator.dart';
import 'package:swift11/views/splash_screen/Home_Screen/home.dart';

class PayentMethods extends StatelessWidget {
  const PayentMethods({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();


    return Obx(
      ()=> Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child:controller.placingOrder.value?Center(
            child: loadingIndicator(),
          ): ourButton(
            onPress: ()async{

             await controller.placeMyOrders(orderPaymentMethod: paymentsMeThods[controller.paymentIndex.value],
                  totalAmount: controller.totalp.value );
             await controller.clearCart();
             VxToast.show(context, msg: "Order Placed successfully");
             Get.offAll(Home());


            },
            color: redColor,
            textColor: whiteColor,
            title: "place my order",

          ),
        ),
        appBar: AppBar(
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),

        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
              ()=> Column(

              children: List.generate(paymentMethodImg.length, (index){
                return GestureDetector(
                  onTap: (){
                    controller.changePayMentIndex(index);
                  },
                  child: Container(

                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(

                        color: controller.paymentIndex.value == index ?  redColor:Colors.transparent,
                        width: 4,
                      )

                    ),
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(paymentMethodImg[index],width: double.infinity,

                          colorBlendMode: controller.paymentIndex.value == index ?BlendMode.darken:BlendMode.color,
                          color:controller.paymentIndex.value == index ? Colors.black.withOpacity(0.3):Colors.transparent,
                          height: 100,fit: BoxFit.cover,),
                       controller.paymentIndex.value == index? Checkbox(
                            activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),

                            value: true, onChanged: (value){

                        }):
                           Container(),

                        Positioned(
                            bottom: 0,
                            right: 10,
                            child: paymentsMeThods[index].text.white.fontFamily(semibold).size(16).make()),
                      ],
                    )
                  ),
                );
              })

            ),
          ),
        ),
      ),
    );
  }
}
