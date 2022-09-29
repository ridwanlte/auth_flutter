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

  var user_email = TextEditingController();
  TextEditingController user_password = new TextEditingController();

  Future _loginAccount() async {
    setState(() {
      isLoading = true;
    });
    try {
      print("CEK");
      var res = await http.post(Uri.parse(loginAccount), body: {
        'user_email': null,
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
            children: [
              Text(
                "Email Address",
                style: TextStyle(
                  color: bodyTextColor,
                  fontFamily: 'Poppin',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: defaultPadding / 2),
              TextFormField(
                controller: user_email,
                validator: (val) {
                  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val.toString());
                  if(val!.isEmpty) return 'Email is required';
                  else if( val.isNotEmpty && !emailValid) return 'Format email not Valid';
                },
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Poppin',
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(defaultPadding / 2),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultPadding / 2),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultPadding / 2),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none)),
                    filled: true,
                    hintStyle: TextStyle(
                        fontFamily: 'Poppin',
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        color: primaryColor.withOpacity(0.7)),
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.mail, color: primaryColor),
                    
                    hintText: 'mathilda@gmail.com'),
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
                  if(val== null || val.isEmpty) return 'Password is required';
                  else if(val.length < 8) return "Minimal password 8 character";
                },
                obscureText: _isObscure,
                autofocus: false,
                style: TextStyle(
                    color: primaryColor, fontSize: 16, fontFamily: 'Poppin'),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defaultPadding/ 2),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultPadding/2),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none
                )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultPadding/2),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none
                )
              ),
              filled: true,
              hintStyle: TextStyle(
                fontFamily: 'Poppin',
                fontSize: 14,
                
                color: primaryColor.withOpacity(0.7)
              ),
              fillColor: Colors.white,
              // prefixIconColor: primaryColor,
              // iconColor: primaryColor,
              // focusColor: primaryColor,
              prefixIcon: Icon(Icons.lock, color: Colors.black),
              hintText: 'Enter password',
              suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    color: primaryColor,
                    onPressed: () {
                      setState(() {
                        _isObscure = _isObscure;
                      });
                    },
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
