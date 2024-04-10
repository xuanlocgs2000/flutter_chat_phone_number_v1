import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';
import 'package:flutter_chat_ffb/presentation/pages/item/select_contact_page.dart';
import 'package:flutter_chat_ffb/presentation/pages/item/single_item_chat_page.dart';

// import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';
// import 'package:flutter_chat_ffb/presentation/bloc/my_chat/my_chat_cubit.dart';
// import 'package:flutter_chat_ffb/presentation/pages/sub_pages/select_contact_page.dart';
// import 'package:flutter_chat_ffb/presentation/pages/sub_pages/single_communication_page.dart';
// import 'package:flutter_chat_ffb/presentation/pages/sub_pages/single_item_chat_user_page.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';
// import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final UserEntity userInfo;
  const ChatPage({super.key, required this.userInfo});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // Text("Chat page"),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 10,
        //     itemBuilder: (_, index) {
        //       return SingleItemChatUserPage();
        //     },
        //   ),
        // )
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: greenColor.withOpacity(.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: Icon(
            Icons.message,
            color: Colors.white.withOpacity(.6),
            size: 40,
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Start chat with your friends ",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.4)),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          // debugPrint("Contacts: $UserInfo");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SelectContactPage(
                        userInfo: widget.userInfo,
                      )));
        },
        child: Icon(Icons.chat),
      ),
    );
  }
  // Widget _myChatList(){
  //   return
  // }
}
