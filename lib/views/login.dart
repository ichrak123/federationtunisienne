import 'dart:convert' show jsonDecode;

import 'package:federationtunisienne/views/arbitrehome.dart';
import 'package:federationtunisienne/views/coachhome.dart';
import 'package:federationtunisienne/views/playerhome.dart';
import 'package:federationtunisienne/views/clubowner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String msg;
  late String error;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future startLogin() async {
    var response = await http.post(
      Uri.http('192.168.1.4', 'federationtunisienne/login.php'),
      body: {
        'phone': usernameController.text,
        'password': passwordController.text,
      },
    );
    setState(() {
      msg = jsonDecode(response.body);
    });

    switch (msg) {
      case '1':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ClubOwnerHome()));
        break;
      case '2':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PlayerHome()));
        break;
      case '3':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ArbitreHome()));
        break;
      case '4':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CoachHome()));
        break;
      case 'false':
        setState(() {
          error = 'false';
        });
        break;
      case 'not exists':
        error = 'null';
        break;
    }
  }

  bool hidePassword = true;
  void hidePass() {
    if (hidePassword) {
      setState(() {
        hidePassword = false;
      });
    } else {
      setState(() {
        hidePassword = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                width: 90,
                height: 90,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Bienvenue",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La féderation tunisienne de Yoseikan Budo",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(50)),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          errorText:
                              error == 'null' ? 'phone not correct' : null,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon:
                                new Icon(Icons.supervised_user_circle_rounded),
                          ),
                          labelText: 'Login',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            errorText: error == 'false'
                                ? 'password not correct'
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: IconButton(
                              icon: hidePassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onPressed: hidePass,
                            ),
                            labelText: 'Mot de passe'),
                        obscureText: hidePassword ? true : false,
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          // ignore: deprecated_member_use
                          child: ElevatedButton(
                            onPressed: startLogin,
                            child: Text(
                              "Continuer",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                    ),
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
