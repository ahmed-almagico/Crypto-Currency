import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  var _email = TextEditingController();

  var _password = TextEditingController();

  var _name = TextEditingController();

  bool x = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .1),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  TextFormField(
                    controller: _name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text('Name'),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: x,
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
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (x == true) {
                                x = false;
                              } else if (x == false) {
                                x = true;
                              }
                            });
                          },
                          icon: x
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .05,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(28, 94, 32, 1)),
                      child: TextButton(
                        onPressed: () {
                          provider.register(
                              _name.text, _email.text, _password.text);
                        },
                        child: Text('Sign Up',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          'Login',
                          style:
                              TextStyle(color: Color.fromRGBO(88, 186, 87, 1)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
