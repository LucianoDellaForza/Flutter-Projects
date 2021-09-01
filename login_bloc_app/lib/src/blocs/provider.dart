import 'package:flutter/material.dart';

import 'bloc.dart';

//Bloc scoped way
class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

//15. Consuming BLOC Data - 5. The Provider's 'of' function
  static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        .bloc;
  }
}
