import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/shared/loading_spinner.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  const SignInScreen({Key key, this.toggleView}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  String _email = '';
  String _password = '';
  String _error = '';
  final _formKey = GlobalKey<FormState>();
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
              title: Text('Sign In to Brew Crew'),
              backgroundColor: Colors.brown[400],
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
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
                            ? 'Email field can\'t be empty.'
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
                        validator: (value) => value.isEmpty
                            ? 'Password can\'t be less than 6 chars.'
                            : null,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Colors.brown,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            // print(_email);
                            // print(_password);
                            setState(() => _loading = true);
                            var result = await _auth.signInWithEmailAndPassword(
                                _email, _password);
                            if (result == null) {
                              setState(() {
                                _error =
                                    'Something went wrong please check your credentials ';
                                _loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        _error,
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
