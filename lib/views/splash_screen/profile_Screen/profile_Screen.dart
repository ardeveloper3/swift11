// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:swift11/Home_controller/auth_controller.dart';
import 'package:swift11/Home_controller/profile_controller.dart';
import 'package:swift11/Widgets_common/bg_widget.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/images.dart';
import 'package:swift11/consts/lists.dart';
import 'package:swift11/consts/loadingIndicator.dart';
import 'package:swift11/consts/styles.dart';
import 'package:swift11/services/firestore_services.dart';
import 'package:swift11/views/chat_screen/messaging_screen.dart';
import 'package:swift11/views/orders_screen/orders_screen.dart';
import 'package:swift11/views/splash_screen/auth_screen/login_screen.dart';
import 'package:swift11/views/splash_screen/profile_Screen/components/details_card.dart';
import 'package:swift11/views/splash_screen/profile_Screen/edite_profile/edite_profile_screen.dart';
import 'package:swift11/views/wishList_screen/wishlist_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(profileController());
    return bgWidget(
        Scaffold(
          body: StreamBuilder(
              stream: FirestorServices.getUser(currentUser!.uid),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                }else{
                  var data =snapshot.data!.docs[0] ;

                  return SafeArea(
                    child: Column(

                      children: [
                        //edite profile

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.edit,color: whiteColor,)).onTap(() {

                            controller.namecontroller.text = data['name'];


                            //go edite page
                            Get.to(()=>EditeProfileScreen(data: data,));
                          }),
                        ),


                        //users details section
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [

                              data['imgUrl'] ==''?

                              Image.asset(
                                imgProfile2,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make():
                              Image.network(
                                data['imgUrl'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                              10.widthBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "${data['name']}".text.fontFamily(semibold).white.make(),
                                    "${data['email']}".text.white.make(),
                                  ],
                                ),
                              ),

                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: whiteColor,
                                  ),
                                ),
                                onPressed: () {
                                  Get.put(AuthController()).signOutMethode(context: context);
                                  Get.offAll(()=>LoginScreen());
                                },
                                child: "logout".text.fontFamily(semibold).white.make(),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,


                        FutureBuilder(

                            future: FirestorServices.getCounts(),


                            builder: (BuildContext context,AsyncSnapshot snapshot){

                              if(!snapshot.hasData){
                                return loadingIndicator();
                              }else{
                                var CountData = snapshot.data;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(count: "${CountData[0]}",title: "in your cart ",width: context.screenWidth/3.4),
                                    detailsCard(count: "${CountData[1]}",title: "in your wish List ",width: context.screenWidth/3.2),
                                    detailsCard(count: "${CountData[2]}",title: "your order ",width: context.screenWidth/3.4),
                                  ],
                                );
                              }


                            }),

                        20.heightBox,

                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder:(context ,index) {
                            return Divider(color: lightGrey,);
                          },
                          itemCount: profileButtonList.length,
                          itemBuilder:(BuildContext context , int index){
                            return ListTile(
                              onTap: (){
                                switch(index){
                                  case 0 :
                                    Get.to(()=>OrdersScreen());
                                    break;
                                  case 1 :
                                    Get.to(()=>WishListScreen());
                                    break;
                                  case 2:
                                    Get.to(()=>MessagesScreen());
                                    break;
                                }
                              },
                              leading: Image.asset(profileButtonIcon[index],width: 22,color: darkFontGrey,),
                              title: profileButtonList[index].text.fontFamily(bold).make(),
                            );
                          } ,


                        ).box.white.rounded.padding(EdgeInsets.symmetric(horizontal: 16)).margin(EdgeInsets.all(12)).shadowSm.make().box.color(redColor).make(),

                      ],
                    ),
                  );
                }
              }
          ),
        ));
  }
}