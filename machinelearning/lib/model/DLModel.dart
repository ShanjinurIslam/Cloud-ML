import 'model.dart';

class DLModel extends Model {
  final String useCase;

  DLModel({id, name, apiName, this.useCase, catagory})
      : super(id: id, name: name, apiName: apiName, catagory: catagory);

  factory DLModel.fromJson(Map<String, dynamic> json) {
    return DLModel(
        id: json['id'],
        name: json['name'],
        apiName: json["api_name"],
        useCase: json['use_case'],
        catagory: json['catagory']);
  }
}
