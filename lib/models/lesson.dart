class Lesson {
  late String id;
  late String codeName;
  late String name;
  late String? subName;

  Lesson({
    required this.id,
    required this.codeName,
    required this.name,
    this.subName,
  });
}
