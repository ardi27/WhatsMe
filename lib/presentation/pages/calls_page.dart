import 'package:flutter/material.dart';
import 'package:whatsme/presentation/pages/sub_pages/single_item_call_page.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index)=>SingleItemCallPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: primaryColor,
        child: Icon(Icons.add_call,color: Colors.white,),
      ),
    );
  }
}
