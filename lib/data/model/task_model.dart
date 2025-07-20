class TaskModel {
  final String id;
  final String title;
  final String description;
  final int priority;
  final DateTime date;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title': title,
      'description': description,
      'priority': priority,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id:json['id'] ??'',
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
    );
  }
}
