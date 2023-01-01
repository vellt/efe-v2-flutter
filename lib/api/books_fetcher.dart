import 'package:efe_v2_flutter/api/networking.dart';
import 'package:efe_v2_flutter/api/secret.dart' as secret;
import 'package:efe_v2_flutter/models/book.dart';

class BooksFetcher {
  Future<List<Book>> init() async {
    List<Book> temp = [];
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(secret.apiBooksUrl));
    var data = await networkHelper.getData();
    if (data != null) {
      for (var dataItem in data) {
        int index = dataItem['data']['index'];
        String title = dataItem['data']['title'];
        String route = dataItem['data']['route'];
        temp.add(Book(
          id: index,
          name: title,
          route: route,
        ));
      }
    }
    return Future.value(temp);
  }
}
