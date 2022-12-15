class Vehicle {
  Vehicle({
    this.chassisNo,
    this.stockId,
    this.publishedDateTime,
  });

  String? chassisNo;
  String? stockId;
  String? publishedDateTime;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    chassisNo: json["ChassisNo"],
    stockId: json["StockId"],
    publishedDateTime: json["PublishedDateTime"],
  );

  Map<String, dynamic> toJson() => {
    "ChassisNo": chassisNo,
    "StockId": stockId,
    "PublishedDateTime": publishedDateTime,
  };
}
