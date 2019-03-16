import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String nameString, emailString, passwordString;
  final formKey = GlobalKey<FormState>();

  Widget showTitle = Text('Please Register');

  Widget nameTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name :', hintText: 'Name User'),
      validator: (String valueName) {
        if (valueName.length == 0) {
          return 'Please Fill Name not Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  Widget emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address:', hintText: 'you@email.com'),
      validator: (String value) {
        if (!value.contains('@')) {
          return 'Please Type Email Format you@gmail.com';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Password:', hintText: 'more 6 Charator'),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Please Type Password more 6 Charator';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  void checkValueBeforeUpload(BuildContext context) {
    print('You Click Upload');
    print(formKey.currentState.validate());
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(
          'name = $nameString, email = $emailString, password = $passwordString');
      uploadValueToServer(context, nameString, emailString, passwordString);
    }
  }

  void uploadValueToServer(
      BuildContext context, String name, String email, String password) async {
    String urlString =
        'https://www.androidthai.in.th/chit/addUserMaster.php?isAdd=true&Name=$name&Email=$email&Password=$password';
    print('url = $urlString');

    var response =await get(urlString);
    var result = json.decode(response.body);
    print('result = $result');

    if (result.toString() == 'true') {
      Navigator.pop(context);
    } else {
      print('Cannot Upload');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          actions: <Widget>[
            IconButton(
              tooltip: 'Upload to Server',
              icon: Icon(Icons.cloud_upload),
              onPressed: () {
                checkValueBeforeUpload(context);
              },
            )
          ],
        ),
        body: Form(
          key: formKey,
          child: Container(
              padding: EdgeInsets.only(top: 60.0),
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Column(
                  children: <Widget>[
                    nameTextField(),
                    emailTextField(),
                    passwordTextField()
                  ],
                ),
              )),
        ));
  } // Build Method
} // _Register State Class
