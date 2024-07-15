import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_app/constants.dart';
import 'package:scholar_chat_app/cubits/chats/chats_cubit.dart';
import 'package:scholar_chat_app/helper/chat_bubble.dart';
import 'package:scholar_chat_app/models/messege_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = 'Chatting';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isLoading = true;

  final _controller = ScrollController();

  TextEditingController controller = TextEditingController();

  List<MessegeModel> messegesList = [];
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    String input = '';
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
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
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                'Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatsCubit, ChatsState>(
              builder: (context, state) {
                if (state is ChatSuccess) {
                  messegesList = state.messeges;
                  return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messegesList.length,
                    itemBuilder: (context, index) => (email ==
                            messegesList[index].email)
                        ? ChatBubbleOfSender(text: messegesList[index].messege)
                        : ChatBubbleFromOthers(
                            text: messegesList[index].messege),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                input = value;
              },
              onSubmitted: (data) async {
                if (data != '') {
                  BlocProvider.of<ChatsCubit>(context)
                      .addMessege(email: email, content: data);
                  await animateToMaxPosition();
                }
              },
              decoration: InputDecoration(
                label: const Text('Messege'),
                hintText: 'Enter Messege',
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 20, 79, 127),
                    )),
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
  }

  Future<void> animateToMaxPosition() async {
    controller.clear();
    try {
      await _controller.animateTo(
        _controller.position.minScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeIn,
      );
    } catch (e) {
      //
    }
  }
}
