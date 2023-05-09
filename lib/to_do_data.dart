class ToDoData {
  String title;
  String description;

  ToDoData({ required this.title, required this.description});

  static List<ToDoData> getToDoData() {
    return <ToDoData>[
      ToDoData(title: "Flutter", description: "The Framework's Introduction"),
      ToDoData(title: "Dart", description: "Behind the App - Backend"),
      ToDoData(title: "React.js", description: "Users View - Frontend"),
      ToDoData(title: "Java", description: "The Advanced Level of Programming"),
      ToDoData(title: "Spring Boot", description: "The Commercial Beast"),
      ToDoData(title: "IOT", description: "Introduction to IOT"),

    ];
  }
}
