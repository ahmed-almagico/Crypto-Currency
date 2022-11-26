import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/view/design/home.dart';
import 'package:graduation_project/view/design/login_screen.dart';
import 'package:graduation_project/view/widgets/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'control.dart';

class Splash extends StatefulWidget {
  @override

  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var id ;
  var gid ;
  getDuration() async {
    await Future.delayed(Duration(seconds: 2), () {});
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    gid = preferences.getString("gid");
    id == null && gid == null ? Get.offAll( LoginScreen())  : Get.offAll( Nav() ) ;
 //   Get.to(Control())
    ;}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDuration();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
        SvgPicture.asset(
          'assets/undraw_bitcoin_re_urgq.svg',
          width: 200,
        )
      ])),
    );
  }
}
