import 'package:auth_flutter/components/form_input.dart';
import 'package:auth_flutter/components/logo_app.dart';
import 'package:auth_flutter/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primaryColor, secondaryColor])),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  LogoApp(),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: bodyTextColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppin'),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  FormInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
