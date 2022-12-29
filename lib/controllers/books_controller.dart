import 'package:efe_v2_flutter/api/books_api.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:get/get.dart';

class BooksController extends GetxController {
  List<Book> _books = [];

  Rx<int> selectedIndex = 0.obs;

  Book getBook({required int index}) {
    return _books[index];
  }

  List<Book> getBooks() {
    return _books;
  }

  @override
  Future onInit() async {
    super.onInit();
    BooksApi booksApi = BooksApi();
    _books = await booksApi.init();

    ever(
      selectedIndex,
      (_) => print(
          "$_ has been changed: ${getBook(index: selectedIndex.value).name}"),
    );
  }
}
