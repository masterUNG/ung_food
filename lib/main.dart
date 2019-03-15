import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

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
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Password', hintText: 'more 6 Charator'),
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.blue[600],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      color: Colors.blue[200],
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[signInButton(), signUpButton()],
              )
            ],
          ),
        ),
      ),
    );
  }
}
