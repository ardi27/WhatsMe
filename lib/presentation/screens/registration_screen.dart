import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsme/presentation/bloc/auth/auth_cubit.dart';
import 'package:whatsme/presentation/bloc/auth_phone/phone_auth_cubit.dart';
import 'package:whatsme/presentation/pages/phone_verification_pages.dart';
import 'package:whatsme/presentation/pages/set_intial_profile_pages.dart';
import 'package:whatsme/presentation/screens/home_screen.dart';
import 'package:whatsme/presentation/widgets/theme/String.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';
import 'package:country_pickers/country.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("62");
  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  TextEditingController _phoneAuthController = TextEditingController();

  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context,phoneAuthState){
        if(phoneAuthState is PhoneAuthSuccess){
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
      },
      builder: (context, phoneAuthState) {
        if(phoneAuthState is PhoneAuthSmsCodeReceived){
          return PhoneVerificationPages();
        }
        if(phoneAuthState is PhoneAuthProfileInfo){
          return SetInitialProfilePages();
        }
        if(phoneAuthState is PhoneAuthLoading){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if(phoneAuthState is PhoneAuthSuccess){
          return BlocBuilder(
              builder:(context,authState){
                if(authState is Authenticated){
                  return HomeScreen(uid: authState.uid,);
                }
                return Container();
              },
          );
        }
        return _bodyWidget();
      },
    );
  }

  Widget _bodyWidget() {
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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
            ListTile(
              onTap: _openFilteredCountryPickerDialog,
              title: _buildDialogItem(_selectedFilteredDialogCountry),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.5, color: greenColor))),
                  width: 80,
                  alignment: Alignment.center,
                  height: 42,
                  child: Text("${_selectedFilteredDialogCountry.phoneCode}"),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(hintText: "Phone Number"),
                      )),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: greenColor,
                  onPressed: _submitVerifyPhoneNumber,
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

  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
            data: Theme.of(context).copyWith(primaryColor: primaryColor),
            child: CountryPickerDialog(
              titlePadding: EdgeInsets.all(8),
              searchCursorColor: Colors.black,
              isSearchable: true,
              searchInputDecoration: InputDecoration(
                hintText: "Search",
              ),
              title: Text("Select your phone code"),
              onValuePicked: (country) {
                _selectedFilteredDialogCountry = country;
                _countryCode = country.phoneCode;
                setState(() {});
              },
              itemBuilder: _buildDialogItem,
            )));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: greenColor, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8,
          ),
          Text("+${country.phoneCode}"),
          SizedBox(
            width: 8,
          ),
          Text(
            country.name,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
  void _submitVerifyPhoneNumber(){
    if(_phoneAuthController.text.isNotEmpty){
      BlocProvider.of<PhoneAuthCubit>(context).submitVerifyPhoneNumber(phoneNumber: "+$_countryCode${_phoneAuthController.text}");
    }
  }
}
