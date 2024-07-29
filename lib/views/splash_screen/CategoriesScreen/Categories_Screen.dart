// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:swift11/Home_controller/product_conroller.dart';
import 'package:swift11/Widgets_common/bg_widget.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/lists.dart';
import 'package:swift11/consts/strings.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/views/splash_screen/CategoriesScreen/categries_ditails.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(CategoriesImages[index],height: 120,width: 200,fit: BoxFit.cover,),
                    10.heightBox,
                    "${CategoriesList[index]}".text.color(darkFontGrey).align(TextAlign.center).make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make().onTap(() {
                      controller.getSubCategories(CategoriesList[index]);
                      Get.to(()=>CategoryDetails(title: CategoriesList[index]));
                });
              }),
        )));
  }
}
