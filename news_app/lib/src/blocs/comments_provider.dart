import 'package:flutter/material.dart';

import 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  late final CommentsBloc bloc;

  CommentsProvider({Key? key, required Widget child})
      : super(key: key, child: child) {
    bloc = CommentsBloc();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>()
            as CommentsProvider)
        .bloc;
  }
}
