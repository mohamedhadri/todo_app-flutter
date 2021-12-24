class Task {
  Task(this.text);
  Task.Test(this.text, this.isDone);
  Task.Empty();

  String text = "";
  bool isDone = false;
  bool isFivorit = false;

  List<String>? subTasks;
  String notes = "";
  DateTime? remindMe;
}
