class Task {
  String name;
  DateTime createdAt;
  bool completed;

  Task({
    required this.name,
    required this.createdAt,
    required this.completed,
  });

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        completed = json['completed'].toString().toLowerCase() == 'true',
        createdAt = DateTime.parse(json['createdAt']);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'completed': completed ? "true" : "false"
    };
  }
}
