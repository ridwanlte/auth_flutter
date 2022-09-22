import 'dart:convert';

import 'package:auth_flutter/components/form_input.dart';
import 'package:auth_flutter/constants.dart';
import 'package:auth_flutter/network/api.dart';
import 'package:auth_flutter/network/session_manager.dart';
import 'package:auth_flutter/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future _loginAccount() async {
    setState(() {
      isLoading = true;
    });
    try {
      var user_password;
      var user_email;
      var res = await http.post(Uri.parse(loginAccount), body: {
        'user_email': user_email.text,
        'user_password': user_password.text
      });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
          sessionManager.savePref(data['user']['id'], data['user']['user_nama'], data['user']['user_email'], data['token']);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => Homepage()), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Success'),
            ),
          );
        });
      } else if(res.statusCode == 400){
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${data['data']['message']}')));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, secondaryColor])),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Form(
                key: _keyForm,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset('assets/images/logo_app.png'),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: bodyTextColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    FormInput(),
                    SizedBox(
                      height: defaultPadding * 2,
                    ),
                    isLoading
                        ? Center(
                            child: CupertinoActivityIndicator(
                              radius: defaultPadding,
                              color: bodyTextColor,
                            )
                                // CircularProgressIndicator(color: bodyTextColor),
                          )
                        : MaterialButton(
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                _loginAccount();
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height /
                                defaultPadding,
                            color: bodyTextColor,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: bodyTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
