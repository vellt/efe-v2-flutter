import 'package:efe_v2_flutter/api/networking.dart';
import 'package:efe_v2_flutter/api/secret.dart' as secret;
import 'package:efe_v2_flutter/models/audio.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:efe_v2_flutter/models/lesson.dart';

class EfeApi {
  final List<Audio> audios = [];
  final List<Book> books = [];
  final List<Lesson> lessons = [];

  //init
  Future Init() async{
    await getBooks();

  }

  Future getBooks() async {
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(secret.apiBooksUrl));
    var data = await networkHelper.getData();
    if (data != null) {
      for (var dataItem in data) {
        int index = dataItem['data']['index'];
        String title = dataItem['data']['title'];
        String route = dataItem['data']['route'];
        books.add(Book(
          id: index,
          name: title,
          route: route,
        ));
      }
    }
  }

  Future getBook(String id)async {}

  Future getDataFromBook(Book book) async {
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(secret.getFullURLFromBookRoute(book.route)));
    var data = await networkHelper.getData();
    if (data != null) {
      int lessonIndex = 0;
      for (var item in data["ref"]["documents"]) {
        for (var lesson in item["data"]["exercises"]) {
          int lessonId=lessonIndex;
          String lessonCodeName = "${item["data"]["index"]}.${lesson["index"]}";
          String lessonTitle = lesson["customTitle"] ?? item["data"]["title"];
          /*
          String mainTitle = lessonTitle.split("-")[0];
          String? subtitle =
              lessonTitle.split("-").length == 2 ? lessonTitle.split("-")[1].trim() : null;
          */

          lessons.add(
            Lesson(
              id: lessonId,
              name: lessonTitle,
              codeName: lessonCodeName,
            )
          );


          int audioIndex=0;
          for (var audio in lesson["audio"]) {
            String audioTitle = (audio["text"] ?? audio["number"] ?? "").toString();
            String audioUrl = '${audio["filepath"]}${audio["filename"]}';
            audios.add(
                Audio(
                  id: audioIndex++,
                  name: audioTitle,
                  voiceUrl: audioUrl,
                  bookID: book.id,
                  isFavorite: false,
                  lessionID: lessonId,
                ));
          }


        }
      }

  }

  Future getAudios() async{}
}
