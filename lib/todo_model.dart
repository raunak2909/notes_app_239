class TodoModel{
  String title;
  String desc;
  bool isCompleted;
  int createdAt;
  int completedAt;
  int priority; //1-> high, 2-> med, 3-> low

  TodoModel({
    required this.title,
    required this.desc,
    this.isCompleted = false,
    required this.createdAt
});

}