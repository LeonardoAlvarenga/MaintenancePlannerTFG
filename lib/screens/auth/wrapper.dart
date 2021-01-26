import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/services/auth.dart';
import 'package:tfg_app/screens/auth/authentication_screen.dart';
import '../home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFb = Provider.of<UserFb>(context);

    return userFb == null ? AuthScreen() : HomeScreen();
  }
}
