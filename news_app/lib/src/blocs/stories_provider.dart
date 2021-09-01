import 'package:flutter/material.dart';

import 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  late final StoriesBloc bloc;

  StoriesProvider({Key? key, required Widget child})
      : super(key: key, child: child) {
    bloc = StoriesBloc();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>()
            as StoriesProvider)
        .bloc;
  }
}
