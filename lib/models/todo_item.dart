class TodoItem {
  String title;
  DateTime dateTime;
  bool completed;

  TodoItem({
    required this.title,
    required this.dateTime,
    required this.completed,
  });

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        completed = json['completed'].toString().toLowerCase() == 'true',
        dateTime = DateTime.parse(json['datetime']);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': dateTime.toIso8601String(),
      'completed': completed ? "true" : "false"
    };
  }
}
