import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/bloc.dart';
import 'package:login_bloc/src/blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          emailField(bloc),
          passwordField(bloc),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(bloc)
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        var error = snapshot.error;
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'email@example.com',
            labelText: 'Email Address',
            //errorText: snapshot.error,
          ),
          onChanged: (newTextInputValue) {
            bloc.changeEmail(newTextInputValue);
          },
        );
      },
    );
  }

  // Widget emailField() {
  //   return TextField(
  //     keyboardType: TextInputType.emailAddress,
  //     decoration: InputDecoration(
  //       hintText: 'email@example.com',
  //       labelText: 'Email Address',
  //     ),
  //     onChanged: (newTextValue) {},
  //   );
  // }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            //errorText: snapshot.error,
          ),
          onChanged: (newTextInputValue) {
            bloc.changePassword(newTextInputValue);
          },
        );
      },
    );
  }

  // Widget passwordField() {
  //   return TextField(
  //     obscureText: true,
  //     decoration: InputDecoration(
  //       labelText: 'Password',
  //     ),
  //   );
  // }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValidStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData ? bloc.submit : null,
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text('Submit'),
        );
      },
    );
  }
}
