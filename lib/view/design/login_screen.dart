import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/view/design/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme.dart';
import '../../provider/auth_provider.dart';


class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var _email = TextEditingController();

  var _password = TextEditingController();
  bool x = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context , provider , child){
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery
              .of(context)
              .size
              .width * .1),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * .2,),
                  Text("Sign In",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * .03,),
                  TextFormField(
                    controller: _email,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),

                      ),

                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    obscureText: x,
                    controller: _password,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      label: Text('Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          if (x == true){
                            x=false ;
                          }
                          else if(x==false) {
                            x=true ;
                          }
                        });
                      } , icon: x?Icon(Icons.visibility_off) :Icon( Icons.visibility)),
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * .02,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(28, 94, 32, 1)),
                        width: double.infinity,
                        /*
                      if(_formKey.currentState!.validate()) {
                        }
                      */
                        child: TextButton(onPressed: () {
                          if (_formKey.currentState!.validate()) {
                           provider.login(_email.text, _password.text) ;
                          }
                         setdata();
                        },
                          child: Text('Sign In ',
                            style: TextStyle(fontSize: 20, color: Colors
                                .white),),)
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * .01,),
                  Text('Or'),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * .01,),
                  GestureDetector(
                      onTap: () {
                        provider.googleSignIn();
                      },
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 1,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Themes.isDarkMode(context) ?  Color(0xff151f2c) : Colors.black ,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/google.png', height: MediaQuery
                                .of(context)
                                .size
                                .height * .04,),
                            SizedBox(width: MediaQuery
                                .of(context)
                                .size
                                .width * .02,),
                            Text('Sign in with Google', style: TextStyle(
                                color: Colors.white),),
                          ],
                        ),
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''' If you don't have an Account'''),
                      TextButton(
                        onPressed: () {
                          Get.to(RegisterScreen());
                        },
                        child: Text(
                          'Sign Up', style: TextStyle(color: Color.fromRGBO(88,
                            186, 87, 1)),),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      );
    }) ;
  }
}

setdata() async{
  SharedPreferences pref = await SharedPreferences.getInstance() ;
  pref.getString('email');
}