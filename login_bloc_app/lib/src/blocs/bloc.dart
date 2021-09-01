import 'dart:async';
import 'package:login_bloc/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  // final _emailController = StreamController<
  //     String>.broadcast(); //broadcast - if we want multiple listeners
  // final _passwordController = StreamController<String>.broadcast();

  //We use BehaviorSubject (special StreamController) instead of StreamController becase we want the latest value to be remembered,
  //so when submit button is clicked we can take those email and password values
  final _emailController = BehaviorSubject<String>(); //by default is broadcast
  final _passwordController = BehaviorSubject<String>();

  /** GETTERS **/
  // Add data to streams
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Retrieve data from streams
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  //Observable is deprecated (rxdart: ^0.16.7 in pubspec.yaml) - Rx class is substitute
  Stream<bool> get submitValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);
  //if we get both values, return true so that Submit button will be valid

  // getteri mogu i kao funkcije
  // void changeEmailFun(String emailValue) {
  //   _emailController.sink.add(emailValue);
  // }

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  // clean up function
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

// Bloc global instance way
// final bloc = Bloc();
