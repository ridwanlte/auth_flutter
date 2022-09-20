import 'package:auth_flutter/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primaryColor, secondaryColor])),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Center(
                  child: Image.asset('assets/images/logo_app.png'),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: bodyTextColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  'Email Address',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: bodyTextColor),
                ),
                SizedBox(height: defaultPadding / 2),
                TextFormField(
                  // controller: user_email,
                  validator: (val) {
                    return val!.isEmpty ? 'Email is required' : null;
                  },
                  autofocus: false,
                  style: TextStyle(color: primaryColor, fontSize: 16),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: bodyTextColor,
                    hintText: 'Email',
                    hintStyle: TextStyle(color: primaryColor),
                    prefixIcon: Icon(
                      Icons.email,
                      color: primaryColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: bodyTextColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
