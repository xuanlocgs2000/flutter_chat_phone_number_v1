import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ffb/domain/entities/contact_entity.dart';
import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';
import 'package:flutter_chat_ffb/presentation/cubit/get_device_number/get_device_numbers_cubit.dart';
import 'package:flutter_chat_ffb/presentation/cubit/user/user_cubit.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectContactPage extends StatefulWidget {
  final UserEntity userInfo;

  const SelectContactPage({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDeviceNumbersCubit, GetDeviceNumbersState>(
      builder: (context, contactNumberState) {
        if (contactNumberState is GetDeviceNumbersLoaded) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              if (userState is UserLoaded) {
                final List<ContactEntity> contacts = [];
                final dbUsers = userState.users
                    .where((user) => user.uid != widget.userInfo.uid)
                    .toList();
                contactNumberState.contacts.forEach((deviceUserNumber) {
                  dbUsers.forEach(
                    (dbUser) {
                      if (dbUser.phoneNumber ==
                          deviceUserNumber.phoneNumber.replaceAll(' ', '')) {
                        contacts.add(ContactEntity(
                          label: dbUser.name!,
                          phoneNumber: dbUser.phoneNumber!,
                          uid: dbUser.uid,
                          status: dbUser.status,
                        ));
                      }
                    },
                  );
                });
                debugPrint("Contacts: $contacts");
                return Scaffold(
                  appBar: AppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select Contact"),
                        Text(
                          "${contacts.length} contacts",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    actions: [
                      Icon(Icons.search),
                      Icon(Icons.more_vert),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        _newGroupButtonWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        _newContactButtonWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        _listContact(contacts),
                      ],
                    ),
                  ),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _newGroupButtonWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "New Group",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _newContactButtonWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "New contact",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listContact(List<ContactEntity> contacts) {
    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (ctx, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Image.asset('assets/profile_default.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${contacts[index].label}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Hello.",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
