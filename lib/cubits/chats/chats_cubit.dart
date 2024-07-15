// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat_app/constants.dart';
import 'package:scholar_chat_app/models/messege_model.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  CollectionReference messeges =
      FirebaseFirestore.instance.collection(kMessegesCollection);

  List<MessegeModel> messgesList = [];
  ChatsCubit() : super(ChatsInitial());
  Future<void> addMessege(
      {required String email, required String content}) async {
    await messeges.add(
      {
        'id': email,
        kMessage: content,
        kCreatedAt: DateTime.now(),
      },
    );
  }

  void fetchMesseges() {
    messeges.orderBy(kCreatedAt, descending: true).snapshots().listen(
      (event) {
        messgesList.clear();
        for (var doc in event.docs) {
          messgesList.add(MessegeModel.fromJSon(doc));
        }
        emit(ChatSuccess(messgesList));
      },
    );
  }
}
