class ServerStatus {
  String status;

  ServerStatus({
    this.status,
  });
  factory ServerStatus.fromJson(Map<String, dynamic> json) => new ServerStatus(
    status: json["status"],
  );
}