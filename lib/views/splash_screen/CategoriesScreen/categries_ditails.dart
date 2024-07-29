// ignore_for_file: prefer_const_constructors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:swift11/Home_controller/product_conroller.dart';
import 'package:swift11/Widgets_common/bg_widget.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/images.dart';
import 'package:swift11/consts/loadingIndicator.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/services/firestore_services.dart';
import 'package:swift11/views/splash_screen/CategoriesScreen/item_Details.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    // TODO: implement initState
switchCategory(widget.title);
    super.initState();
  }

  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethode =    FirestorServices.getSubCategoryProducts(title);
    }else{
      productMethode  =   FirestorServices.getproducts(title);
    }
  }


  var controller = Get.find<ProductController>();

  dynamic productMethode;


  @override
  Widget build(BuildContext context) {
    var  controller = Get.find<ProductController>();
    return bgWidget(Scaffold(
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).white.make(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                      .text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .makeCentered()
                      .box
                      .padding(EdgeInsets.all(5))
                      .margin(EdgeInsets.all(5))
                      .white
                      .roundedSM
                      .size(150, 50)
                      .make().onTap(() {
                        switchCategory("${controller.subcat[index]}");
                        setState(() {});
                      })),
            ),
          ),

          StreamBuilder(
              stream: productMethode,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                }else if(snapshot.data!.docs.isEmpty){
                  return Expanded(
                    child: "No products found ! ".text.color(darkFontGrey).makeCentered(),
                  );
                }else{

                  var data = snapshot.data!.docs;

                  return Expanded(
                      child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              mainAxisExtent: 250,
                              crossAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                "${data[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                "${data[index]['p_price']}"
                                .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .shadowSm
                                .outerShadowSm
                                .white
                                .margin(EdgeInsets.symmetric(horizontal: 4.0))
                                .roundedSM
                                .padding(EdgeInsets.all(8.0))
                                .white
                                .make().onTap(() {
                                  controller.checkIfFav(data[index]);
                              Get.to(()=>ItemDetails(title: "${data[index]['p_name']}",data: data[index],));
                            });
                          }));
                }
              }
          ),
        ],
      )
    )
    );
  }
}
