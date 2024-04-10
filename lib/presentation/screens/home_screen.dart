// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';
import 'package:flutter_chat_ffb/presentation/pages/call_page.dart';
import 'package:flutter_chat_ffb/presentation/pages/chat_page.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/custom_tab_bar.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';

class HomeScreen extends StatefulWidget {
  // final String uid;
  final UserEntity userInfo;
  const HomeScreen({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearch = false;
  int _currentPageIndex = 0;
  PageController _pageViewController = PageController(initialPage: 1);
  List<Widget> get _pages => [
        ChatPage(
          userInfo: widget.userInfo,
        ),
        // StatusPage(),
        // CallsPage()
      ];
  Widget _buildSearch() {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 45),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            offset: Offset(0.0, 0.50))
      ]),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: InkWell(
            onTap: () {
              //TODO:
              setState(() {
                _isSearch = false;
              });
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _isSearch == false ? primaryColor : Colors.transparent,
        title: _isSearch == false
            ? Text("ChatApp")
            : Container(
                height: 0.0,
                width: 0.0,
              ),
        flexibleSpace: _isSearch == false
            ? Container(
                height: 0.0,
                width: 0.0,
              )
            : _buildSearch(),
        actions: <Widget>[
          InkWell(
              onTap: () {
                setState(() {
                  _isSearch = true;
                });
              },
              child: Icon(Icons.search)),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: Column(
        children: [
          // TODO:CustomTabBar
          _isSearch == false
              ? CustomTabBar(index: _currentPageIndex)
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton(
          //     icon: Icon(Icons.more_vert),
          //     isDense: true,
          //     onChanged: (value) {},
          //     isExpanded: false,
          //     items: [],
          //   ),
          // ),
          Expanded(
            child: PageView.builder(
              itemCount: _pages.length,
              controller: _pageViewController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return _pages[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
