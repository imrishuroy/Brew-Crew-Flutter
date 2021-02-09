import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/loading_spinner.dart';
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
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? LoadingSpinner()
        : Scaffold(
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
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.brown[200],
                              width: 2.5,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        validator: (value) => value.isEmpty
                            // || !value.contains('@gmail.com')
                            ? 'Please enter a valid email.'
                            : null,
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.brown[200],
                              width: 2.5,
                            ),
                          ),
                        ),
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
                            setState(() {
                              _loading = true;
                            });
                            var result =
                                await _auth.registerWithEmailAndPassword(
                                    _email, _password);
                            if (result == null) {
                              setState(() {
                                error = 'Something went wrong.';
                                _loading = false;
                              });
                              //print(result.toString());
                            }
                            // await _auth.sendEmailVerification();
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
                      SizedBox(height: 15.0),
                      // FlatButton(
                      //     onPressed: () async {
                      //       var result = await _auth.sendEmailVerification();
                      //       if (result != null) {
                      //         setState(() {});
                      //       }
                      //     },
                      //     child: Text(
                      //       'Send Email verification link',
                      //       style: TextStyle(
                      //         fontSize: 17.0,
                      //       ),
                      //     )),
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
