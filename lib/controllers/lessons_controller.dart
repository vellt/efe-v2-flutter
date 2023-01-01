import 'package:efe_v2_flutter/api/lessons_fetcher.dart';
import 'package:efe_v2_flutter/models/audio.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:efe_v2_flutter/models/lesson.dart';
import 'package:get/get.dart';

class LessonsController extends GetxController {
  LessonsController(Book book) {
    _book = Book(
      id: book.id,
      name: book.name,
      route: book.route,
    );
  }

  List<Lesson> _lessons = [];
  List<Audio> _audios = [];
  late Book _book;
  Rx<int> indexOfSelectedLesson = 0.obs;
  Rx<int> indexOfSelectedAudio = 0.obs;

  Book getBook() {
    return _book;
  }

  /// If you dont give any index values as parameters the function will returned with the current lesson object
  Audio getAudio({int? index}) {
    if (index != null) return _audios[index];
    return _audios[indexOfSelectedAudio.value];
  }

  /// this returned with all of favorites audio which is inside of the CURRENT book, when you set isFavorite as value true, and the lesson is null.
  /// If you dont give any lessons as parameters, this will give all of the book's audios.
  List<Audio> getAudios({Lesson? lesson, bool? isFavorite}) {
    // lesson not null, isFavorite null-->only the lessons' audios, which are in the book
    if (lesson != null) {
      List<Audio> tempOfLessons = [];
      for (var audio in _audios) {
        if (audio.lessionID == lesson.id) {
          tempOfLessons.add(audio);
        }
      }
      return tempOfLessons;
    }
    // lesson null, isFavorite not null-->all of the audios which marked as favorite, which are in the book
    if (isFavorite != null) {
      List<Audio> tempOfFavorites = [];
      for (var audio in _audios) {
        if (audio.isFavorite) {
          tempOfFavorites.add(audio);
        }
      }
      return tempOfFavorites;
    }
    //lesson null, isFavorite null-->all of the audios which are in the book
    return _audios;
  }

  /// If you dont give any index values as parameters the function will returned with the current lesson object
  Lesson getLesson({int? index}) {
    if (index != null) return _lessons[index];
    return _lessons[indexOfSelectedLesson.value];
  }

  /// If the function doesnt find any matches to the code what you added as parameters it will returned with null value
  int? getLessonID({required String code}) {
    for (var lesson in _lessons) {
      if (lesson.codeName == code) {
        return lesson.id;
      }
    }
    return null;
  }

  List<Lesson> getLessons() {
    return _lessons;
  }

  @override
  Future onInit() async {
    super.onInit();
    //indexOfSelectedLesson.value = 0; todo: must be loading the recent lesson
    //indexOfSelectedAudio.value = 0; todo: must be loading the recent audio
    LessonsFetcher lessonsFetcher = LessonsFetcher(_book);
    await lessonsFetcher.init();
    //the init of the lessonsFetcher doesnt returned us the data because we need two list of data so we use two getters for this assignment
    _lessons = lessonsFetcher.getLessons();
    _audios = lessonsFetcher.getAudios();
    ever(
      indexOfSelectedLesson,
      (_) => print("the current lesson: ${getLesson().name}"),
    );
  }
}
