import 'dart:convert';

import 'package:auth_flutter/constants.dart';
import 'package:auth_flutter/network/api.dart';
import 'package:auth_flutter/network/session_manager.dart';
import 'package:auth_flutter/screens/home_page.dart';
import 'package:auth_flutter/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController user_email = TextEditingController();
  TextEditingController user_password = TextEditingController();

  bool isLoading = false;
  bool _isObscure = true;

  Future _loginAccount() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.post(Uri.parse(loginAccount), body: {
        'user_email': user_email.text,
        'user_password': user_password.text
      });
      var data = jsonDecode(res.body);
      print('dataku, ${data}');
      print('status, ${res.statusCode}');
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
          sessionManager.savePref(data['user']['id'], data['user']['user_nama'], data['user']['user_email']);
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed!')));
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
        child: Container(
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
                  Text(
                    'Email Address',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: bodyTextColor),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: user_email,
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
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: bodyTextColor,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: defaultPadding / 2,
                  ),
                  TextFormField(
                    controller: user_password,
                    validator: (val) {
                      return val!.isEmpty ? 'Password is required' : null;
                    },
                    obscureText: _isObscure,
                    autofocus: false,
                    style: TextStyle(color: primaryColor, fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: bodyTextColor,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: primaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        color: primaryColor,
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
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
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  isLoading
                      ? Center(
                          child:
                              CircularProgressIndicator(color: bodyTextColor),
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterPage()),
                          (route) => false);
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
    );
  }
}
