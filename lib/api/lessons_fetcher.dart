import 'package:efe_v2_flutter/api/networking.dart';
import 'package:efe_v2_flutter/api/secret.dart' as secret;
import 'package:efe_v2_flutter/models/audio.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:efe_v2_flutter/models/lesson.dart';

class LessonsFetcher {
  final List<Audio> _audios = [];
  final List<Lesson> _lessons = [];
  late Book _book;

  LessonsFetcher(Book book) {
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
            id: lessonIndex,
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
          lessonIndex++;
        }
      }
    }
  }

  /// After initialization you should use
  List<Audio> getAudios() {
    return _audios;
  }

  /// After initialization you should use
  List<Lesson> getLessons() {
    return _lessons;
  }
}
