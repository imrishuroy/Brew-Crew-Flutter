import 'package:brew_crew/models/app_user.dart';
import 'package:brew_crew/screens/auth/authenticate.dart';

import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
