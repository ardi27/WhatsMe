import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:whatsme/presentation/bloc/auth_phone/phone_auth_cubit.dart';
import 'package:whatsme/presentation/pages/set_intial_profile_pages.dart';
import 'package:whatsme/presentation/widgets/theme/String.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class PhoneVerificationPages extends StatefulWidget {
  final String phoneNumber;

  const PhoneVerificationPages({Key key, this.phoneNumber}) : super(key: key);
  @override
  _PhoneVerificationPagesState createState() => _PhoneVerificationPagesState();
}

class _PhoneVerificationPagesState extends State<PhoneVerificationPages> {
  String get _phoneNumber=>widget.phoneNumber;
  TextEditingController _pinCodeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Verify Your Phone Number",
          style: TextStyle(color: greenColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
            Text(
              welcomeText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            _pinCodeWidget(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color:greenColor,
                  onPressed: _submitSmsCcode,
                  child: Text("Next",style: TextStyle(fontSize: 18,color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pinCodeWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          PinCodeTextField(
            controller: _pinCodeController,
            length: 6,
            backgroundColor: Colors.transparent,
            obsecureText: true,
            textInputType: TextInputType.number,
            autoDisposeControllers: false,
            onChanged: (value){
              print(value);
            },
          ),
          Text("Enter your 6 digit code")
        ],
      ),
    );
  }
  void _submitSmsCcode(){
    if(_pinCodeController.text.isNotEmpty){
      BlocProvider.of<PhoneAuthCubit>(context).submitSmsCode(smsCode: _pinCodeController.text);
    }
  }
}
