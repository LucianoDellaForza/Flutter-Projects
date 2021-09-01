import 'package:flutter/material.dart';
import 'package:login_stateful/src/mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(
              margin: EdgeInsets.only(top: 25.0),
            ),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'email@example.com',
      ),
      validator: validateEmail,
      onSaved: (String? textFieldValue) {
        if (textFieldValue != null) {
          email = textFieldValue;
        }
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      validator: validatePassword,
      onSaved: (String? textFieldValue) {
        if (textFieldValue != null) {
          password = textFieldValue;
        }
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          formKey.currentState?.save();
          print('Time to post $email and $password to my API');
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
      ),
      child: Text('Submit'),
    );
  }
}
