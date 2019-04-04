class Process {
  String processId;
  String name;
  int setTemp;
  int cookTime;
  int readInt;
  String userId;
  String timeStamp;

  Process(
      {this.processId,
      this.name,
      this.setTemp,
      this.cookTime,
      this.readInt,
      this.userId,
      this.timeStamp});

  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      processId: json["process_id"],
      name: json["name"],
      setTemp: json["set_temp"],
      cookTime: json["cook_time"],
      readInt: json["read_int"],
      userId: json["user_id"],
      timeStamp: json["time_stamp"],
    );
  }
}
