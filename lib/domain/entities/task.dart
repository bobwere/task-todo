class UserTask {
  int? id;
  String title;
  String description;
  String status;
  String? category;
  int? priority;
  String pinned;
  int createAt;
  int updatedAt;

  UserTask({
    this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.category,
    required this.priority,
    required this.createAt,
    required this.updatedAt,
    this.pinned = 'false',
  });

  UserTask.fromMap(Map<String?, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        status = map['status'],
        pinned = map['pinned'],
        category = map['category'],
        priority = map['priority'],
        createAt = map['createAt'],
        updatedAt = map['updatedAt'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
        'pinned': pinned,
        'category': category,
        'priority': priority,
        'createAt': createAt,
        'updatedAt': updatedAt,
      };

  Map<String, dynamic> toTableMap() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status,
        'pinned': pinned,
        'category': category,
        'priority': priority,
        'createAt': createAt,
        'updatedAt': updatedAt,
      };
}
