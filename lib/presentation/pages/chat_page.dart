import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ffb/presentation/pages/item/single_item_chat_page.dart';

// import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';
// import 'package:flutter_chat_ffb/presentation/bloc/my_chat/my_chat_cubit.dart';
// import 'package:flutter_chat_ffb/presentation/pages/sub_pages/select_contact_page.dart';
// import 'package:flutter_chat_ffb/presentation/pages/sub_pages/single_communication_page.dart';
// import 'package:flutter_chat_ffb/presentation/pages/sub_pages/single_item_chat_user_page.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';
// import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // Text("Chat page"),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_, index) {
              return SingleItemChatUserPage();
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
      ),
    );
  }
}
