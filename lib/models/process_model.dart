class Process {
  String processId;
  String name;
  int setTemp;
  int initW;
  int finalW;
  int cookTime;
  int readInt;
  String userId;
  String timeStamp;

  Process(
      {this.processId,
      this.name,
      this.setTemp,
      this.initW,
      this.finalW,
      this.cookTime,
      this.readInt,
      this.userId,
      this.timeStamp});

  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      processId: json["process_id"],
      name: json["name"],
      setTemp: json["set_temp"],
      initW: json["initial_w"],
      finalW: json["final_w"],
      cookTime: json["cook_time"],
      readInt: json["read_int"],
      userId: json["user_id"],
      timeStamp: json["time_stamp"],
    );
  }
}
