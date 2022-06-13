class NoteModel {
  final String? id;
  final String type;
  final String taskName;
  final String description;
  final String time;
  NoteModel(
      {this.id,
      required this.taskName,
      required this.type,
      required this.description,
      required this.time});

  factory NoteModel.fromJson(Object json) {
    if (json is Map<String, dynamic>) {
      return NoteModel(
          id: json['id'],
          taskName: json['taskName'],
          type: json['type'],
          description: json['description'],
          time: json['time']);
    }
    return NoteModel.empty();
  }
  factory NoteModel.empty() {
    return NoteModel(
        id: null,
        taskName: '',
        type: 'Business',
        description: '',
        time: DateTime.now().millisecondsSinceEpoch.toString());
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['taskName'] = taskName;
    json['type'] = type;
    json['description'] = description;
    json['time'] = time;
    return json;
  }
}
