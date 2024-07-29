// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:swift11/Home_controller/product_conroller.dart';
import 'package:swift11/Widgets_common/Our_button.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/images.dart';
import 'package:swift11/consts/lists.dart';
import 'package:swift11/consts/strings.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/views/chat_screen/chat_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
   var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;

      },
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            leading: IconButton(onPressed: (){


              controller.resetValues();
              Get.back();


            },icon: Icon(Icons.arrow_back),),
            backgroundColor: Colors.white,
            title: title!.text.make(),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              Obx(
                  ()=>IconButton(onPressed: () {
                  if(controller.isFav.value){
                    controller.removeFromWishList(data.id,context);

                  }else{
                    controller.addToWishList(data.id,context);

                  }
                }, icon: Icon(Icons.favorite_outline,
                color: controller.isFav.value?redColor:darkFontGrey,
                )),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: (contex, index) {
                            return Image.network(
                              data["p_imgs"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      title!.text
                          .size(16)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        size: 25,
                        count: 5,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                      .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.fontFamily(bold).white.make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make(),
                            ],
                          )),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(()=>ChatScreen(),
                            arguments: [data['p_seller'],data['vendor_id']],
                            );
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      20.heightBox,
                      Obx(
                            () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color:".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                        alignment: Alignment.center,
                                        children:[
                                          VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                            .margin(EdgeInsets.symmetric(horizontal: 6))
                                            .make()
                                              .onTap(() {
                                              controller.changeColorIndex(index);
                                        }),
                                          Visibility(
                                            visible: index == controller.colorIndex.value,

                                              child: Icon(Icons.done,color: Colors.white)),
                                    ]
                                      )

                                  ),
                                )
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),
                            //quentity row

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quentity:".text.color(textfieldGrey).make(),
                                ),
                                Obx(()=> Row(
                                    children: [
                                      IconButton(onPressed: (){

                                        controller.decreaseQuentity();

                                        controller.calculateTotalPrice(int.parse(data['p_quentity']));

                                      }, icon: Icon(Icons.remove)),
                                      controller.quentity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                      IconButton(onPressed: (){
                                        controller.increaseQuantity(int.parse(data['p_quentity']));

                                        controller.calculateTotalPrice(int.parse(data['p_quentity']));

                                      }, icon: Icon(Icons.add)),
                                      "(${data['p_quentity']} available)".text.color(textfieldGrey).make(),

                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),
                            //total row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total:".text.color(textfieldGrey).make(),
                                ),

                               "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),

                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),

                          ],
                        ).box.white.shadowSm.make(),
                      ),
                      10.heightBox,
                      "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),

                      //button action

                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(itemDitailsButtonList.length, (index) =>
                        ListTile(
                          title: "${itemDitailsButtonList[index]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                          trailing: Icon(Icons.arrow_forward),

                        )
                        ),
                      ),
                      //products mau like section
                      20.heightBox,

                      productsmayLike.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
                      10.heightBox,

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: Row(
                          children: List.generate(6, (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                              10.heightBox,
                              "Laptop 4GB/64GB ".text.fontFamily(semibold).color(darkFontGrey).make(),
                              "\$600".text.color(redColor).fontFamily(bold).size(16).make(),


                            ],
                          ).box.shadowSm.white.margin(EdgeInsets.symmetric(horizontal: 4.0)).roundedSM.padding(EdgeInsets.all(8.0)).white.make()),


                        ),
                      ),

                    ],
                  ),
                ),
              )),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ourButton(
                    color: redColor,
                    onPress: () {
                     if(controller.quentity.value>0){
                       controller.addToCart(
                         color: data['p_colors'][controller.colorIndex.value],
                         context: context,

                         vendorID: data['vendor_id'],
                         img: data['p_imgs'][0],

                         qty: controller.quentity.value,

                         sellerName: data['p_seller'],
                         title: data['p_name'],
                         tprice: controller.totalPrice.value,
                       );
                       VxToast.show(context, msg: "Added to cart ");
                     }else{
                       VxToast.show(context, msg: "Minimum 1 product is required");
                     }
                    },
                    textColor: whiteColor,
                    title: "Add to Cart"),

              )
            ],
          )),
    );
  }
}
