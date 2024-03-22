class TodoModel {
  final int? id;
  final String title;
  final int isCompleted;
  final String createdAt;
  final String updatedAt;

  TodoModel({
    this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'is_completed': isCompleted,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
