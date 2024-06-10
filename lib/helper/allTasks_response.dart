// ignore_for_file: file_names, prefer_collection_literals, unnecessary_new, unnecessary_this

class AllTasksResponse {
  int? id;
  String? date;
  String? taskname;
  String? firsttime;
  String? endtime;
  bool? completed;

  AllTasksResponse(
      {this.id, this.date, this.taskname, this.firsttime, this.endtime, this.completed});

  AllTasksResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    taskname = json['taskname'];
    firsttime = json['firsttime'];
    endtime = json['endtime'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['taskname'] = this.taskname;
    data['firsttime'] = this.firsttime;
    data['endtime'] = this.endtime;
    data['completed'] = this.completed;
    return data;
  }
}