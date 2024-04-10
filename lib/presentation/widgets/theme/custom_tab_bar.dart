import 'package:flutter/material.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';

class CustomTabBar extends StatelessWidget {
  final int index;

  const CustomTabBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: primaryColor),
      child: Row(
        children: <Widget>[
          // Container(
          //   width: 40,
          //   child: Icon(
          //     Icons.camera_alt,
          //     color: Colors.white,
          //   ),
          // ),
          Expanded(
            child: CustomTabBarButton(
              text: "CHATS",
              textColor: index == 0 ? textIconColor : textIconColorGray,
              borderColor: index == 0 ? textIconColor : Colors.transparent,
            ),
          ),
          // Expanded(
          //   child: CustomTabBarButton(
          //     text: "STATUS",
          //     textColor: index == 2 ? textIconColor : textIconColorGray,
          //     borderColor: index == 2 ? textIconColor : Colors.transparent,
          //   ),
          // ),
          Expanded(
            child: CustomTabBarButton(
              text: "CALLS",
              textColor: index == 1 ? textIconColor : textIconColorGray,
              borderColor: index == 1 ? textIconColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String text;
  final Color? borderColor;
  final Color? textColor;
  final double borderWidth;

  const CustomTabBarButton({
    Key? key,
    required this.text,
    this.borderColor,
    this.textColor,
    this.borderWidth = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: borderColor ?? Colors.transparent, width: borderWidth),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black,
        ),
      ),
    );
  }
}
