class ToDoData {
  final String title;
  final String description;

  const ToDoData({
    required this.title,
    required this.description,
  });

  ToDoData copy({
    String? firstName,
    String? lastName,
  }) =>
      ToDoData(
        title: firstName ?? this.title,
        description: lastName ?? this.description,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ToDoData &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              description == other.description;
  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}