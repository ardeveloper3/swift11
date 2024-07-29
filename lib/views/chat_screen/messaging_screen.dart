import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/loadingIndicator.dart';
import 'package:swift11/services/firestore_services.dart';
import 'package:swift11/views/chat_screen/chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages ".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestorServices.getAllMessages(),
          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Messages yet!".text.color(darkFontGrey).make(),
              );
            }else{
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder:(BuildContext context,int index){
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  Get.to(()=>ChatScreen(),
                                    arguments: [
                                      data[index]['frient_Name'],
                                      data[index]['toId'],
                                    ],);
                                },
                                leading: CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(Icons.person,color: Colors.white,),
                                ),
                                title: "${data[index]['friend_Name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                subtitle: "${data[index]['last_msg']}".text.make(),


                              ),
                            );
                          }
                          ),
                    ),
                  ],
                ),
              );
            }
          }
          ),
    );
  }
}
