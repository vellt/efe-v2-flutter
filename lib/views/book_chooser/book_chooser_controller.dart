import 'package:efe_v2_flutter/api/books_fetcher.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookChooserController extends GetxController {
  List<Book> _books = [];
  int indexOfSelectedBook = 0;
  bool isTapped = false;
  int indexOfTappedIcon = 0;

  /// If you dont give any parameters, this function will be returning with the current selected Book
  Book getBook({int? index}) {
    if (index != null) return _books[index];
    return _books[indexOfSelectedBook];
  }

  /// This function is returning with all of efe's book
  List<Book> getBooks() {
    return _books;
  }

  void selectBook(int index) {
    if (indexOfSelectedBook != index) {
      indexOfSelectedBook = index;
      update();
    }
  }

  void changeTappedValue(bool value, int index) {
    if (isTapped != value) {
      indexOfTappedIcon = index;
      isTapped = value;
      update();
    }
  }

  void downloadBook(int index) {
    Get.snackbar(
      "Downloading started",
      getBook(index: index).name.toString(),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey[300],
      borderRadius: 10,
      icon: const Icon(
        Icons.download,
      ),
    );
  }

  @override
  Future onInit() async {
    super.onInit();
    //indexOfSelectedAudio.value = 0; todo: must be loading the recent book
    BooksFetcher booksFetcher = BooksFetcher();
    _books = await booksFetcher.init();
  }
}
