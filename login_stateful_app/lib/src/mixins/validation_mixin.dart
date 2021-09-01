class ValidationMixin {
  String? validateEmail(String? textFieldValue) {
    // return null if valid, otherwise string error message
    if (textFieldValue != null) {
      if (!textFieldValue.contains('@')) {
        return 'Please enter a valid email';
      } else
        return null;
    }
  }

  String? validatePassword(String? textFieldValue) {
    if (textFieldValue != null) {
      if (textFieldValue.length < 4) {
        return 'Password must be at least 4 characters';
      } else
        return null;
    }
  }
}
