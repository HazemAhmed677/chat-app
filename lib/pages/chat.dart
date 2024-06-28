import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/constants.dart';
import 'package:scholar_chat_app/helper/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'Chatting';

  bool isLoading = true;

  CollectionReference messeges =
      FirebaseFirestore.instance.collection(kMessegesCollection);

  final _controller = ScrollController();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messeges.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                toolbarHeight: 70,
                automaticallyImplyLeading: false,
                // take care title take widget not only text
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 60,
                    ),
                    const Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>
                          (email == snapshot.data!.docs[index]['id'])
                              ? ChatBubble(
                                  text: snapshot.data!.docs[index][kMessage],
                                )
                              : ChatBubbleFromFriend(
                                  text: snapshot.data!.docs[index][kMessage]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        if (data != '') {
                          messeges.add(
                            {
                              'id': email,
                              kMessage: data,
                              kCreatedAt: DateTime.now(),
                            },
                          );
                          controller.clear();
                          _controller.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      },
                      decoration: InputDecoration(
                        label: const Text('Messege'),
                        hintText: 'Enter Messege',
                        suffixIcon: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const ModalProgressHUD(
              inAsyncCall: true,
              child: Scaffold(),
            );
          }
        });
  }
}
