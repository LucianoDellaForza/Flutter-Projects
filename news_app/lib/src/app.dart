import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/news_detail.dart';

import 'screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'Hacker News',
          // home: NewsList(),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    //home route
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();

          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final commentsBloc = CommentsProvider.of(context);
          // extract item id from settings.name and pass to NewsDetail()
          final itemId =
              int.parse(settings.name!.replaceFirst('/', '')); // '/23' -> 23
          // A fantastic location to do some initialization or data fetching for NewsDetail()
          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}
