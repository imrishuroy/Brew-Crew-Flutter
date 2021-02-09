import 'package:brew_crew/services/auth_service.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key key, this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String _email = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await _auth.signInAnounmously();

          if (result == null) {
            print('Error sigin');
          } else {
            print('Succussfully sign');
            print(result.uid);
          }
        },
        child: Icon(Icons.connect_without_contact),
      ),
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Text('Sign Up to Brew Crew'),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  validator: (value) =>
                      value.isEmpty || !value.contains('@gmail.com')
                          ? 'Please enter a valid email.'
                          : null,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  validator: (value) => value.length < 6
                      ? 'Enter a password greater than 6 chars.'
                      : null,
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.brown,
                  onPressed: () async {
                    // print(_email);
                    // print(_password);
                    if (_formKey.currentState.validate()) {
                      var result = await _auth.registerWithEmailAndPassword(
                          _email, _password);
                      if (result == null) {
                        setState(() {
                          error = 'Something went wrong';
                        });
                      }
                      // print(_email);
                      // print(_password);
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
