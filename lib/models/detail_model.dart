class Details {
  String processId;
  num temperature;
  num humidity;
  String timeStamp;

  Details({this.processId, this.temperature, this.humidity, this.timeStamp});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      processId: json["process_id"],
      temperature: json["temp"],
      humidity: json["hum"],
      timeStamp: json["time_stamp"],
    );
  }
}
