import 'package:flutter/material.dart';
import 'package:whatsme/presentation/pages/sub_pages/single_item_chat_user_page.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_,index)=>SingleItemChatUserPage(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: Icon(Icons.message),
      ),
    );
  }
}
