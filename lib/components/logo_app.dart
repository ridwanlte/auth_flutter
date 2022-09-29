import 'package:auth_flutter/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        SvgPicture.asset(
          "assets/images/logo.svg",
          height: 130,
          width: 130,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "TokoLoak",
          style:
              TextStyle(fontFamily: 'Abe', fontSize: 30, color: bodyTextColor),
        ),
        Text(
          
          "Get Anything What You Want",
          style: TextStyle(
              color: bodyTextColor, fontSize: 10, fontFamily: 'Poppin'),
        )
      ],
    ));
  }
}
