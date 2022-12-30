import 'package:efe_v2_flutter/api/books_api.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:get/get.dart';

class BooksController extends GetxController {
  List<Book> _books = [];
  Rx<int> selectedIndex = 0.obs;

  /// If you dont give any parameters, this function will be returning with the current selected Book
  Book getBook({int? index}) {
    if (index != null) return _books[index];
    return _books[selectedIndex.value];
  }

  /// This function is returning with all of efe's book
  List<Book> getBooks() {
    return _books;
  }

  @override
  Future onInit() async {
    super.onInit();
    //selectedIndex.value = 0; todo: must be loading the recent book
    BooksApi booksApi = BooksApi();
    _books = await booksApi.init();
    ever(
      selectedIndex,
      (_) => print("the current book: ${getBook().name}"),
    );
  }
}
