// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/loadingIndicator.dart';
import 'package:swift11/services/firestore_services.dart';
import 'package:swift11/views/splash_screen/CategoriesScreen/item_Details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future:FirestorServices.searchProducts(title) ,
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return loadingIndicator();
            }else if(snapshot.data!.docs.isEmpty){

              return "No product found like this please search with right keyword".text.color(darkFontGrey).makeCentered();

            }else{

              var data = snapshot.data!.docs;

              var filtered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();

              return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300,),

                children: filtered.mapIndexed((currentValue, index)=>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filtered[index]['p_imgs'][0],
                          height: 150,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        "${filtered[index]['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        "${filtered[index]['p_price']}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(16)
                            .make(),
                      ],
                    ) .box
                        .shadowSm
                        .white
                    .outerShadowMd
                        .margin(
                        EdgeInsets.symmetric(horizontal: 4.0))
                        .roundedSM
                        .padding(EdgeInsets.all(8.0))
                        .white
                        .make().onTap(() {
                          Get.to(()=>ItemDetails(title: "${filtered[index]['p_name']}",data: filtered[index],));
                    })
                ).toList(),
              );
            }
          })
    );
  }
}
