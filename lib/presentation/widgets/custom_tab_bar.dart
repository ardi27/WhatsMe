import 'package:flutter/material.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class CustomTabBar extends StatelessWidget {
  final int index;

  const CustomTabBar({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: primaryColor),
      child: Row(
        children: [
          Container(
            width: 40,
            child: Icon(Icons.camera_alt,color: Colors.white,),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: "CHATS",
              textColor: index==1?textIconColor:textIconColorGrey,
              borderColor: index==1?textIconColor:Colors.transparent,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: "STATUS",
              textColor: index==2?textIconColor:textIconColorGrey,
              borderColor: index==2?textIconColor:Colors.transparent,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: "CALLS",
              textColor: index==3?textIconColor:textIconColorGrey,
              borderColor: index==3?textIconColor:Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  const CustomTabBarButton(
      {Key key, this.text, this.borderColor, this.borderWidth=3, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: borderColor, width: borderWidth))),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }
}
