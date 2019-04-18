class Details {
  String processId;
  num temperature;
  num temperature1;
  num temperature2;
  num temperature3;
  num humidity;
  num humidity1;
  num humidity2;
  num humidity3;
  String timeStamp;

  Details(
      {this.processId,
      this.temperature,
      this.temperature1,
      this.temperature2,
      this.temperature3,
      this.humidity,
      this.humidity1,
      this.humidity2,
      this.humidity3,
      this.timeStamp});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      processId: json["process_id"],
      temperature: json["temp"],
      temperature1: json["temp1"],
      temperature2: json["temp2"],
      temperature3: json["temp3"],
      humidity: json["hum"],
      humidity1: json["hum1"],
      humidity2: json["hum2"],
      humidity3: json["hum3"],
      timeStamp: json["time_stamp"],
    );
  }
}
