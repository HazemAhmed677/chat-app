import 'package:flutter/material.dart';
import 'package:scholar_chat_app/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.text, super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding:
            const EdgeInsets.only(top: 32, bottom: 32, left: 15, right: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleFromFriend extends StatelessWidget {
  const ChatBubbleFromFriend({required this.text, super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding:
            const EdgeInsets.only(top: 32, bottom: 32, left: 15, right: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
          color: Color(0xff0B788F),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
