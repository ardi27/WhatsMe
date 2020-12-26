import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsme/presentation/widgets/theme/String.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Verify Your Phone Number",style: TextStyle(color: greenColor),),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            Text(welcomeText,style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,)
          ],
        ),
      ),
    );
  }
}
