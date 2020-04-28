class ServerStatus {
  String status;
  int number ;

  ServerStatus({
    this.status,
    this.number
  });
  factory ServerStatus.fromJson(Map<String, dynamic> json) => new ServerStatus(
    status: json["status"],
    number: json["number_models"]
  );
}