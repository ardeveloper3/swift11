// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift11/Home_controller/chats_controller.dart';
import 'package:swift11/consts/consts.dart';
import 'package:swift11/consts/loadingIndicator.dart';
import 'package:swift11/services/firestore_services.dart';
import 'package:swift11/views/chat_screen/components/snder_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {


    var controler  = Get.put(ChatsController());


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "${controler.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
            ()=>
                controler.isLoading.value?
                 Center(
                child: loadingIndicator(),
                         ):

                Expanded(
                  child: StreamBuilder(
                      stream: FirestorServices.getChatMessages(controler.chatDocId.toString()),
                      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot ){
                       if(!snapshot.hasData){
                         return Center(
                           child: loadingIndicator(),
                         );
                       }else if(snapshot.data!.docs.isEmpty){
                         return Center(
                           child: "Send a message....".text.color(darkFontGrey).make(),
                         );
                       }else{
                         return ListView(
                           children: snapshot.data!.docs.mapIndexed((currentValue, index){

                             var data = snapshot.data!.docs[index];
                             return Align(
                                 alignment: data['uid'] == currentUser!.uid?
                                 Alignment.centerRight: Alignment.centerLeft,
                                 child: senderBubble(data));

                           }).toList()
                         );
                       }
                      }))
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controler.msgController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: textfieldGrey,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: textfieldGrey,
                    )),
                    hintText: "Type a message...",
                  ),
                )),
                IconButton(
                    onPressed: () {
                      controler.sendMsg(controler.msgController.text);
                      controler.msgController.clear();
                    },
                    icon: Icon(
                      color: redColor,
                      Icons.send,
                    )),
              ],
            )
                .box
                .height(80)
                .padding(EdgeInsets.all(12))
                .margin(EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
