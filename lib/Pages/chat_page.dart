import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar/helper/const.dart';
import 'package:scholar/models/message_model.dart';

import '../Widgets/bubble_chat.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = "chat_page";

  ChatPage({super.key});
  String? messagestext;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(Kcollection);
  final controller = TextEditingController();
  Stream<DocumentSnapshot>? data;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(Ktime, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: KprimaryColor,
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  KphotoPath,
                  height: 50,
                ),
                const Text(
                  "Chat",
                )
              ]),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        if (messageList[index].email == email) {
                          return bubbleChat(text: messageList[index]);
                        } else {
                          return bubbleChatUserII(text: messageList[index]);
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        Kmessage_field: data,
                        Ktime: DateTime.now(),
                        KIdentifier: email
                      });
                      controller.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      scrollController.jumpTo(0);
                    },
                    onChanged: (data) {
                      messagestext = data;
                    },
                    decoration: InputDecoration(
                        hintText: "Send message",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            messages.add({
                              Kmessage_field: messagestext,
                              Ktime: DateTime.now(),
                              KIdentifier: email
                            });
                            controller.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                            scrollController.jumpTo(0);
                          },
                          child: const Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 10, 79, 135),
                            size: 50,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: KprimaryColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: KprimaryColor))),
                  ),
                )
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
