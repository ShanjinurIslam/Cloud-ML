import 'dart:convert';

///Use this https://app.quicktype.io/ converter tool to create your ///data class according to the JSON response.
///API used here is - https://jsonplaceholder.typicode.com/posts/1

///Used to map JSON data fetched from the server
ServerStatus responseFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return ServerStatus.fromJson(jsonData);
}
///Model Class
///Make sure the keys here are same as that in
///the response
class ServerStatus {
  String status;

  ServerStatus({
    this.status,
  });

  ///This method is to deserialize your JSON
  ///Basically converting a string response to an object model
  ///Here key is always a String type and value can be of any type
  ///so we create a map of String and dynamic.
  factory ServerStatus.fromJson(Map<String, dynamic> json) => new ServerStatus(
    status: json["status"],
  );
}