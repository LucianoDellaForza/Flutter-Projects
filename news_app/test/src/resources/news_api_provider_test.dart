import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    // setup of test case
    final newsApi = NewsApiProvider();
    // MockClient is for testing api calls
    // whenever get call is called, instead this function will be called
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]),
          200); //1st param - mock json, 2nd param - status code
    });

    final ids = await newsApi
        .fetchTopIds(); //await doesnt really need, because MockClient function will run instantly, but for legitimity

    // expectation
    expect(ids, [1, 2, 3, 4]); //1st param - result, 2nd param - expectation
  });

  test('FetchItem returns ItemModel', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
