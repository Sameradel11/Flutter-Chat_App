import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar/models/message_model.dart';

import '../../helper/const.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(Kcollection);
  void sendMessage({required String messagetext, required String email}) {
    messages.add({
      Kmessage_field: messagetext,
      Ktime: DateTime.now(),
      KIdentifier: email
    });
  }

  void retreiveMessages() {
    messages.orderBy(Ktime, descending: true).snapshots().listen((event) {
      List<Message> messagelist = [];
      for (var doc in event.docs) {
        messagelist.add(Message.fromjson(doc));
      }
      emit(ChatSuccess(messageslist: messagelist));
    });
  }
}
