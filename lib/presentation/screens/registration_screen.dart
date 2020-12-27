import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:whatsme/presentation/pages/phone_verification_pages.dart';
import 'package:whatsme/presentation/widgets/theme/String.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';
import 'package:country_pickers/country.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode("62");
  String _countryCode = "+62";

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
                    border: Border(bottom: BorderSide(width: 1.5,color: greenColor))
                  ),
                  width: 80,
                  alignment: Alignment.center,
                  height: 42,
                  child: Text("${_selectedFilteredDialogCountry.phoneCode}"),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Container(
                    height: 40,
                    child:TextField(
                      decoration: InputDecoration(
                        hintText: "Phone Number"
                      ),
                    )
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color:greenColor,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>PhoneVerificationPages()));
                  },
                  child: Text("Next",style: TextStyle(fontSize: 18,color: Colors.white),),
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
              onValuePicked: (country){
                _selectedFilteredDialogCountry=country;
                _countryCode=country.phoneCode;
                setState(() {
                });
              },
              itemBuilder: _buildDialogItem,
            )));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: greenColor,width: 1)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8,),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8,),
          Text(country.name),
          Spacer(),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}
