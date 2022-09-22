import 'dart:convert';

import 'package:auth_flutter/constants.dart';
import 'package:auth_flutter/network/api.dart';
import 'package:auth_flutter/network/session_manager.dart';
import 'package:auth_flutter/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormInput extends StatefulWidget {
  const FormInput({Key? key}) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  bool _isObscure = true;

  bool isLoading = false;

   TextEditingController user_email = new TextEditingController();
   TextEditingController user_password = new TextEditingController();

  Future _loginAccount() async {
    setState(() {
      isLoading = true;
    });
    try {
      print("CEK");
      var res = await http.post(Uri.parse(loginAccount), body: {
        'user_email': user_email.text,
        'user_password': user_password.text
      });
      var data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
          sessionManager.savePref(data['user']['id'], data['user']['user_nama'],
              data['user']['user_email'], data['token']);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => Homepage()), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Success'),
            ),
          );
        });
      } else if (res.statusCode == 400) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data['data']['message']}')));
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
    return Container(
      child: Form(
        key: _keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email Address',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: bodyTextColor,
                    fontFamily: 'Poppin'),
              ),
              SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: user_email,
                validator: (val) {
                  return val!.isEmpty ? 'Email is required' : null;
                },
                autofocus: false,
                style: const TextStyle(
                    color: primaryColor, fontSize: 16, fontFamily: 'Poppin'),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: bodyTextColor,
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(color: primaryColor, fontFamily: 'Poppin'),
                  prefixIcon: Icon(
                    Icons.email,
                    color: primaryColor,
                  ),
                  contentPadding:
                      new EdgeInsets.all(defaultPadding/2),
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
                    fontSize: 18,
                    fontFamily: 'Poppin'),
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
                style: TextStyle(
                    color: primaryColor, fontSize: 16, fontFamily: 'Poppin'),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: bodyTextColor,
                  contentPadding:
                      new EdgeInsets.all(defaultPadding/2),
                  hintText: 'Password',
                  hintStyle:
                      TextStyle(color: primaryColor, fontFamily: 'Poppin'),
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
                      child: CupertinoActivityIndicator(
                      radius: defaultPadding,
                      color: bodyTextColor,
                    ))
                  : MaterialButton(
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          _loginAccount();
                        }
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      height:
                          MediaQuery.of(context).size.height / defaultPadding,
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
            ],
          ),
        ),
      ),
    );
  }
}
