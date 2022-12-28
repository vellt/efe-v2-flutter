import 'package:efe_v2_flutter/api/secret.dart' as secret;
import 'package:efe_v2_flutter/models/audio.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:efe_v2_flutter/models/lesson.dart';

class EfeApi {
  final List<Audio> audios = [];
  final List<Book> books = [];
  final List<Lesson> lessons = [];

  //init
  EfeApi() {}

  Future getBooks() {}

  Future getBook(String id) {}

  Future getLessons() {}

  Future getAudios() {}
}
