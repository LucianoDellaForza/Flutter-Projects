//Validations mixins
import 'dart:async';

class Validators {
  //<String, String> --- input/output of stream transformer
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('Invalid email');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, sink) {
    if (password.length >= 4) {
      sink.add(password);
    } else {
      sink.addError('Password too short');
    }
  });
}
