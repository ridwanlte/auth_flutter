import 'package:auth_flutter/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  const FormInput({Key? key}) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  bool _isObscure = false;

  final TextEditingController user_email = new TextEditingController();
  final TextEditingController user_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
