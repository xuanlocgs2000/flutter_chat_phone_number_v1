import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ffb/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter_chat_ffb/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_chat_ffb/presentation/pages/set_initial_profile.dart';

import 'package:flutter_chat_ffb/presentation/screens/home_screen.dart';
import 'package:flutter_chat_ffb/presentation/pages/phone_verifycation.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static Country _selectedCountry =
      CountryPickerUtils.getCountryByPhoneCode("84");
  String _countryCode = _selectedCountry.phoneCode;
  String _phoneNumber = "";

  TextEditingController _phoneAuthController = TextEditingController();
  @override
  void dispose() {
    _phoneAuthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, phoneAuthState) {
        BlocProvider.of<AuthCubit>(context).loggedIn();
      },
      builder: (context, phoneAuthState) {
        if (phoneAuthState is PhoneAuthSmsCodeReceived) {
          // BlocProvider.of<AuthCubit>(context).loggedIn();
          return PhoneVerificationPage(
            phoneNumber: _phoneNumber,
          );
        }
        if (phoneAuthState is PhoneAuthProfileInfo) {
          return SetInitialProfile(
            phoneNumber: _phoneNumber,
          );
        }
        if (phoneAuthState is PhoneAuthLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (phoneAuthState is PhoneAuthSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                return HomeScreen(
                  uid: authState.uid!,
                );
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
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text("Chat app"),
                  Text(
                    "SIGNIN/SIGNUP ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.more_vert)
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Verify",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListTile(
                  onTap: _openFilteredCountryPickerDialog,
                  title: _buildDialogItem(_selectedCountry),
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1.50,
                      color: greenColor,
                    ))),
                    width: 80,
                    height: 42,
                    alignment: Alignment.center,
                    child: Text("${_selectedCountry.phoneCode}"),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextField(
                        controller: _phoneAuthController,
                        decoration: InputDecoration(hintText: "Phone Number"),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    color: greenColor,
                    // onPressed: _submitVerifyPhoneNumber,
                    onPressed: _submitVerifyPhoneNumber,
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
              data: Theme.of(context).copyWith(
                primaryColor: primaryColor,
              ),
              child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.black,
                searchInputDecoration: InputDecoration(
                  hintText: "Search",
                ),
                isSearchable: true,
                title: Text("Select your phone code"),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedCountry = country;
                    _countryCode = country.phoneCode;
                  });
                },
                itemBuilder: _buildDialogItem,
              ),
            ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: greenColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            height: 8.0,
          ),
          Text("+${country.phoneCode}"),
          SizedBox(
            height: 8.0,
          ),
          Text("${country.name}"),
          Spacer(),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  void _submitVerifyPhoneNumber() {
    if (_phoneAuthController.text.isNotEmpty) {
      _phoneNumber = "+$_countryCode${_phoneAuthController.text}";
      BlocProvider.of<PhoneAuthCubit>(context).submitVerifyPhoneNumber(
        phoneNumber: _phoneNumber,
      );
    }
  }
}
