part of 'chats_cubit.dart';

abstract class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatSuccess extends ChatsState {
  List<MessegeModel> messeges;
  ChatSuccess(this.messeges);
}
