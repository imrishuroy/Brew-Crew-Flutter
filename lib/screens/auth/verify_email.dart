import 'package:brew_crew/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please verify your email'),
            SizedBox(height: 15.0),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.brown[400],
            )
          ],
        ),
      ),
    );
  }
}
