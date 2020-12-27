import 'package:flutter/material.dart';
import 'package:whatsme/presentation/screens/registration_screen.dart';
import 'package:whatsme/presentation/widgets/theme/String.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Welcome to WhatsMe",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Container(
              height: 290,
              width: 290,
              child: Image.asset("assets/brand.png"),
            ),
            Column(
              children: [
                Text(
                  policyText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                MaterialButton(
                  color: greenColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>RegistrationScreen()));
                  },
                  child: Text(
                    "AGREE AND CONTINUE",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
