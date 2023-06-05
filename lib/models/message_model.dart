// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:scholar/helper/const.dart';

class Message {
  String? message;
  String? email;
  Message(this.message, this.email);
  factory Message.fromjson(jsondata) {
    return Message(jsondata[Kmessage_field], jsondata[KIdentifier]);
  }
}
