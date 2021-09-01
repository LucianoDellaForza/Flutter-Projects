import 'dart:async';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news/src/models/item_model.dart';
import 'package:rxdart/subjects.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // Stream getters
  Stream<Map<int, Future<ItemModel>>> get itemWithCommentsStream =>
      _commentsOutput.stream;

  // Sink getters
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>>
      _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, index) {
      print(index);
      cache[id] = _repository.fetchItem(id);
      cache[id]!.then((ItemModel item) {
        item.kids!.forEach((kidId) => fetchItemWithComments(kidId));
      });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  void dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
