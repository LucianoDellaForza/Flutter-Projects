import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';

import 'screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Login Bloc',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
