import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsme/presentation/bloc/auth_phone/phone_auth_cubit.dart';
import 'package:whatsme/presentation/screens/home_screen.dart';
import 'package:whatsme/presentation/widgets/theme/String.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class SetInitialProfilePages extends StatefulWidget {
  final String phoneNumber;

  const SetInitialProfilePages({Key key, this.phoneNumber}) : super(key: key);

  @override
  _SetInitialProfilePagesState createState() => _SetInitialProfilePagesState();
}

class _SetInitialProfilePagesState extends State<SetInitialProfilePages> {
  String get _phoneNumber => widget.phoneNumber;
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile Info",
          style: TextStyle(color: greenColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text(
              profileText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            _rowWidget(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: greenColor,
                  onPressed: _submitProfileInfo,
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rowWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: textIconColorGrey,
                borderRadius: BorderRadius.circular(25)),
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Enter your name"),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: textIconColorGrey,
                borderRadius: BorderRadius.circular(25)),
            child: Icon(Icons.insert_emoticon),
          )
        ],
      ),
    );
  }

  void _submitProfileInfo() {
    if (_nameController.text.isNotEmpty) {
      BlocProvider.of<PhoneAuthCubit>(context).submitProfileInfo(
        name: _nameController.text,
        profileUrl: "",
        phoneNumber: _phoneNumber,
      );
    }
  }
}
