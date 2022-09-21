import 'dart:convert';

import 'package:auth_flutter/constants.dart';
import 'package:auth_flutter/network/api.dart';
import 'package:auth_flutter/network/session_manager.dart';
import 'package:auth_flutter/widget/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController user_nama = TextEditingController();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();
  bool isLoading = false;
  bool _isObscure = true;

  Future _registerAccount() async {
    setState(() {
      isLoading = true;
    });
    try {
      print('dataku, ${user_email.text}, ${user_password.text}, ${user_nama.text}');
      var res = await http.post(Uri.parse(registerAccount), body: {
        'user_email': user_email.text,
        'user_password': user_password.text,
        "user_nama" : user_nama.text
      });
      var data = jsonDecode(res.body);
      print('dataku, ${data}');
      print('status, ${res.statusCode}');
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
      } else if(res.statusCode == 400){
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed!')));
        });
      }
    } catch (e) {
        setState(() {
          isLoading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.toString()}')));
        });
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primaryColor, secondaryColor])),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              LogoApp(),
              SizedBox(
                height: 30,
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                    color: bodyTextColor,
                    fontFamily: 'Poppin',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Form(
              key: _keyForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Full Name',
                              style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: bodyTextColor),
                            ),
                            TextFormField(
                              autofocus: false,
                              controller: user_nama,
                              validator: (val) {
                                return val!.isEmpty ? 'Full Name is required' : null;
                              },
                              style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontSize: 13,
                                  color: primaryColor),
                              decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppin',
                                      color: primaryColor.withOpacity(0.7)),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  filled: true,
                                  contentPadding: new EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 10.0),
                                  fillColor: bodyTextColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Email Address',
                              style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: bodyTextColor),
                            ),
                            TextFormField(
                              controller: user_email,
                              validator: (val) {
                                return val!.isEmpty ? 'Email is required' : null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontSize: 13,
                                  color: primaryColor),
                              decoration: InputDecoration(
                                  hintText: 'johndoe@gmail.com',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppin',
                                      color: primaryColor.withOpacity(0.7)),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: primaryColor,
                                  ),
                                  filled: true,
                                  contentPadding: new EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 10.0),
                                  fillColor: bodyTextColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Password',
                              style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: bodyTextColor),
                            ),
                            TextFormField(
                              autofocus: false,
                              controller: user_password,
                              validator: (val) {
                                return val!.isEmpty ? 'Password is required' : null;
                              },
                              obscureText: _isObscure,
                              style: TextStyle(
                                  fontFamily: 'Poppin',
                                  fontSize: 13,
                                  color: primaryColor),
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    color: primaryColor,
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  hintText: '*******',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppin',
                                      color: primaryColor.withOpacity(0.7)),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: primaryColor,
                                  ),
                                  filled: true,
                                  contentPadding: new EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 10.0),
                                  fillColor: bodyTextColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isLoading
                      ? Center(
                          child:
                              CircularProgressIndicator(color: bodyTextColor),
                        ) :
                      MaterialButton(
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                              _registerAccount();
                            }
                        },
                        minWidth: MediaQuery.of(context).size.width - 50,
                        color: bodyTextColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - defaultPadding * 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: bodyTextColor,
                          fontSize: 13,
                          fontFamily: 'Poppin',
                        ),
                      ),
                    ),
                    Text(
                      "Forget Password ?",
                      style: TextStyle(
                          color: bodyTextColor,
                          fontSize: 13,
                          fontFamily: 'Poppin'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
