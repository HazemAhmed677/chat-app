import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat_app/constants.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  List messgesList = [];
  ChatsCubit() : super(ChatsInitial());
  addMessege(
      {required CollectionReference messeges,
      required String email,
      required String content}) async {
    await messeges.add(
      {
        'id': email,
        kMessage: content,
        kCreatedAt: DateTime.now(),
      },
    );
  }

  fetchMesseges({required CollectionReference messeges}) async {
    messeges.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      emit(ChatSuccess());
    });
  }
}
