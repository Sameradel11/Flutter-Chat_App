import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/const.dart';
import '../models/message_model.dart';

class bubbleChat extends StatelessWidget {
  bubbleChat({
    this.text,
    super.key,
  });
  final scrollController = ScrollController();

  Message? text;
  @override
  Widget build(BuildContext context) {
    print(text!.message);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: KprimaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        child: textnotnull(text!),
      ),
    );
  }

  Text textnotnull(Message text) {
    if (text.message == null) {
      return const Text(
        "NULL",
        style: TextStyle(color: Colors.red, fontSize: 26),
      );
    } else {
      return Text(
        text.message!,
        style: const TextStyle(color: Colors.white, fontSize: 23),
      );
    }
  }
}

class bubbleChatUserII extends StatelessWidget {
  bubbleChatUserII({
    this.text,
    super.key,
  });
  final scrollController = ScrollController();

  Message? text;
  @override
  Widget build(BuildContext context) {
    print(text!.message);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: textnotnull(text!),
      ),
    );
  }

  Text textnotnull(Message text) {
    if (text.message == null) {
      return const Text(
        "NULL",
        style: TextStyle(color: Colors.red, fontSize: 26),
      );
    } else {
      return Text(
        text.message!,
        style: const TextStyle(color: Colors.white, fontSize: 23),
      );
    }
  }
}
