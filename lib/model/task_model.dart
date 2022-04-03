class TaskModel {
  String? uid;
  String? taskID;
  String? taskName;
  String? taskSets;
  String? taskReps;
  String? taskPercentage;
  String? taskDate;

  TaskModel(
      {this.uid,
      this.taskID,
      this.taskName,
      this.taskSets,
      this.taskReps,
      this.taskPercentage,
      this.taskDate});

  // recieve data from server
  factory TaskModel.fromMap(map) {
    return TaskModel(
        uid: map["uid"],
        taskID: map['taskid'],
        taskName: map['taskname'],
        taskSets: map['tasksets'],
        taskReps: map['taskreps'],
        taskPercentage: map['taskper'],
        taskDate: map['taskdate']);
  }

  // send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'taskid': taskID,
      'taskname': taskName,
      'tasksets': taskSets,
      'taskreps': taskReps,
      'taskper': taskPercentage,
      'taskdate': taskDate
    };
  }
}
