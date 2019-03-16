import 'package:flutter/material.dart';
import 'screens/register.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'models/user_model.dart';
import 'screens/my_service.dart';

// void main() {
//   runApp(App());
// }

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ung Food',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String emailString, passwordString;

  void showSnackBar(String message) {
    final snackBar = new SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 20.0),
      ),
      backgroundColor: Colors.red,
      duration: new Duration(seconds: 8),
      action: new SnackBarAction(
        label: 'Hint',
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget nameApp = Text(
    'Ung Food',
    style: TextStyle(
        fontFamily: 'PermanentMarker',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue[700]),
  );

  Widget logo = Image.asset('images/car.png');

  Widget emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address', hintText: 'you@email.com'),
      validator: (String value) {
        if (!value.contains('@')) {
          return 'Please Fill Email Format';
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
          InputDecoration(labelText: 'Password', hintText: 'more 6 Charator'),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Please Type Password More 6 Charator';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  void checkUserAndPass(
      BuildContext context, String email, String password) async {
    print('email = $email, password = $password');
    String urlString =
        'https://www.androidthai.in.th/chit/getUserWhereUserMaster.php?isAdd=true&Email=$email';
    var response = await get(urlString);
    var result = json.decode(response.body);
    print('result = $result');

    if (result.toString() == 'null') {
      showSnackBar('User False');
    } else {
      for (var data in result) {
        print('data = $data');

        var userModel = UserModel.fromJson(data);
        int id = userModel.id;
        String name = userModel.name;
        String truePassword = userModel.password;
        print('name = $name, truePass = $truePassword');

        if (password == truePassword) {
          showSnackBar('Welcome $name');

          var myServiceRoute = new MaterialPageRoute(
              builder: (BuildContext coneext) => MyService(nameLoginString: name,));
              Navigator.of(context).push(myServiceRoute);
        } else {
          showSnackBar('Please Try Again Password False');
        }
      }
    } // if
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {},
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Have Problem'),
      content: Text('User false'),
      actions: <Widget>[okButton],
    );

    showDialog(context) {}
  }

  Widget signInButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[600],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You Click SignIn');
        print(formKey.currentState.validate());
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          checkUserAndPass(context, emailString, passwordString);
        }
      },
    );
  }

  Widget signUpButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[200],
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You Click SignUp');
        var registerRoute = new MaterialPageRoute(
            builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: formKey,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.yellow[900], Colors.yellow],
                    begin: Alignment.topLeft)),
            child: Container(
              margin: EdgeInsets.only(top: 80.0),
              constraints: BoxConstraints.expand(width: 200.0),
              child: Column(
                children: <Widget>[
                  logo,
                  nameApp,
                  emailTextField(),
                  passwordTextField(),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        signInButton(context),
                        signUpButton(context)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
