import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift11/Home_controller/cart_controller.dart';
import 'package:swift11/Widgets_common/Our_button.dart';
import 'package:swift11/Widgets_common/custom_textfield.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/views/splash_screen/Cart_Screen/payment_method.dart';

class ShippinDetails extends StatelessWidget {
  const ShippinDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(

        title: "Shipping info ".text.fontFamily(semibold).color(darkFontGrey).make(),

      ),

      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if(controller.addressController.text.length>10 || controller.cityController.text.isNotEmpty||
                controller.stateController.text.isNotEmpty ||
            controller.postalCodeController.text.isNotEmpty ||
                controller.phoneController.text.isNotEmpty
            )
            {
              Get.to(()=>PayentMethods());

            }else
            {
              VxToast.show(context, msg: "Please fill the form");
            }

          },
          color: redColor,
          textColor: whiteColor,
          title: "continue",

        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextfiled(hint: "Address",isPass: false,title: "Address",controller: controller.addressController),
            customTextfiled(hint: "City",isPass: false,title: "City",controller: controller.cityController),
            customTextfiled(hint: "State",isPass: false,title: "State",controller: controller.stateController),
            customTextfiled(hint: "Postal Code",isPass: false,title: "Postal code",controller: controller.postalCodeController),
            customTextfiled(hint: "Phone",isPass: false,title: "Phone",controller: controller.phoneController),

          ],
        ),
      ),

    );
  }
}
