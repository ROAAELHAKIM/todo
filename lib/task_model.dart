class TaskModel {
  String id;
  String title;
  String description;
 bool? isDone;
  int date;
  String userID;

  TaskModel({
    this.id = "",
    required this.title,
    required this.date,
    required this.description,
    required this.userID,
    this.isDone
   //this.isDone = false,
  });

  TaskModel.fromjson(Map<String, dynamic> json)
      : this(
          title: json['title'],
          date: json['date'],
          description: json['description'],
          isDone: json['is done'],
          id: json['id'],
    userID: json['userID'],
        );

  // TaskModel fromJson(Map<String, dynamic> json) {
  //   return TaskModel(
  //     title: json['title'],
  //     date: json['date'],
  //     description: json['description'],
  //     isDone: json['isdone'],
  //     id: json['id'],
  //   );
  // }
  // map "key": value
  Map<String, dynamic> tojson() {
    return {
      "title": title,
      "date": date,
      "description": description,
      "isDone": isDone,
      "id": id,
      "userID": userID
    };
  }
}
