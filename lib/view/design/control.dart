import 'package:flutter/material.dart';

import 'package:graduation_project/view/widgets/navbar.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';



class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlViewState();
}

class _ControlViewState extends State<Control> {
  @override
  String? email;
  getData()async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString("email");
    print("////////////////////////////////////////// $email");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  Widget build(BuildContext context){
    return email == null ? LoginScreen() : Nav() ;
  }

}
