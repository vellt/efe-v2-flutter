import 'package:efe_v2_flutter/api/books_fetcher.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:get/get.dart';

class BooksController extends GetxController {
  List<Book> _books = [];
  Rx<int> indexOfSelectedAudio = 0.obs;

  /// If you dont give any parameters, this function will be returning with the current selected Book
  Book getBook({int? index}) {
    if (index != null) return _books[index];
    return _books[indexOfSelectedAudio.value];
  }

  /// This function is returning with all of efe's book
  List<Book> getBooks() {
    return _books;
  }

  @override
  Future onInit() async {
    super.onInit();
    //indexOfSelectedAudio.value = 0; todo: must be loading the recent book
    BooksFetcher booksFetcher = BooksFetcher();
    _books = await booksFetcher.init();
    ever(
      indexOfSelectedAudio,
      (_) => print("the current book: ${getBook().name}"),
    );
  }
}
