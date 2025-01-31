import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ffb/presentation/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_chat_ffb/presentation/pages/set_initial_profile.dart';
// import 'package:flutter_chat_ffb/presentation/bloc/phone_auth/phone_auth_cubit.dart';
// import 'package:flutter_chat_ffb/presentation/pages/set_initial_profile_page.dart';
import 'package:flutter_chat_ffb/presentation/widgets/theme/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const PhoneVerificationPage({super.key, required this.phoneNumber});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  String get _phoneNumber => widget.phoneNumber;

  TextEditingController _pinCodeController = TextEditingController();
  @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(""),
                Text(
                  "Verify your phone number",
                  style: TextStyle(
                      fontSize: 18,
                      color: greenColor,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.more_vert)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "SMS sẽ được gửi hoặc dùng phương thức xác minh capcha",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            _pinCodeWidget(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: greenColor,
                  // onPressed: _submitSmsCode,
                  onPressed: _submitSmsCode,
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
        ),
      ),
    );
  }

  Widget _pinCodeWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          PinCodeTextField(
            appContext: context,
            controller: _pinCodeController,
            length: 6,
            backgroundColor: Colors.transparent,
            obscureText: false,
            autoDisposeControllers: false,
            onChanged: (pinCode) {
              print(pinCode);
            },
          ),
          Text("Enter your 6 digit code")
        ],
      ),
    );
  }

  void _submitSmsCode() {
    if (_pinCodeController.text.isNotEmpty) {
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitSmsCode(smsCode: _pinCodeController.text);
    }
  }
}
