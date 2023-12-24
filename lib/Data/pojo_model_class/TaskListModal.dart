
class TaskListModal {
  String? status;
  List<TaskList>? task;
///Pojo class use kori cuz api theke kono kicu get korle seta ei pojo class er maddhomei link kore show kora hoy Ui te.
  TaskListModal({this.status, this.task});

  TaskListModal.fromJson(Map<String, dynamic> json){
    status = json['status'];
    if (json['data'] != null) {
      task = <TaskList>[];
      json['data'].forEach((v) {
        task!.add(TaskList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (task != null) {
      data['data'] = task!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskList {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaskList({this.sId, this.title, this.description, this.status, this.createdDate});

  TaskList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['createdDate'] = createdDate;
    return data;
  }
}
