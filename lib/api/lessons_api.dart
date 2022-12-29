import 'package:efe_v2_flutter/api/networking.dart';
import 'package:efe_v2_flutter/api/secret.dart' as secret;
import 'package:efe_v2_flutter/models/audio.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:efe_v2_flutter/models/lesson.dart';

class LessonsApi {
  final List<Audio> _audios = [];
  final List<Lesson> _lessons = [];
  late Book _book;

  LessonsApi(Book book) {
    _book = Book(
      id: book.id,
      name: book.name,
      route: book.route,
    );
  }

  Future init() async {
    NetworkHelper networkHelper =
        NetworkHelper(Uri.parse(secret.getFullURLFromBookRoute(_book.route)));
    var data = await networkHelper.getData();

    if (data != null) {
      int lessonIndex = 0; //minden ciklus elejekor nullázódik
      for (var item in data["ref"]["documents"]) {
        for (var lesson in item["data"]["exercises"]) {
          String lessonCodeName = "${item["data"]["index"]}.${lesson["index"]}";
          String lessonTitle = lesson["customTitle"] ?? item["data"]["title"];

          _lessons.add(Lesson(
            id: lessonIndex++,
            name: lessonTitle,
            codeName: lessonCodeName,
          ));

          int audioIndex = 0; //minden ciklus elejekor nullázódik
          for (var audio in lesson["audio"]) {
            String audioTitle =
                (audio["text"] ?? audio["number"] ?? "").toString();
            String audioUrl = '${audio["filepath"]}${audio["filename"]}';
            _audios.add(Audio(
              id: audioIndex++,
              name: audioTitle,
              voiceUrl: audioUrl,
              bookID: _book.id,
              isFavorite: false,
              lessionID: lessonIndex,
            ));
          }
        }
      }
    }
  }

  Book getBook() {
    return _book;
  }

  Audio getAudio({required int index}) {
    return _audios[index];
  }

  List<Audio> getAudios() {
    return _audios;
  }

  Lesson? getLesson({int? index, String? code}) {
    if (index != null) return _lessons[index];
    if (code != null) {
      for (var lesson in _lessons) {
        if (lesson.codeName == code) return lesson;
      }
    }
    return null;
  }

  List<Lesson> getLessons() {
    return _lessons;
  }
}
