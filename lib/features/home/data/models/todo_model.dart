class TodoModel {
  final String title;
  final String description;
  bool isDone;
  bool isDoItlater;

  TodoModel({
    required this.title,
    required this.description,
    this.isDone = false,
    this.isDoItlater = false,
  });
}
