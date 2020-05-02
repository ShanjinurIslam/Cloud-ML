import 'model.dart';

class MLModel extends Model {
  final String learningMethod;

  MLModel({id, name, apiName, this.learningMethod, catagory})
      : super(id: id, name: name, apiName: apiName, catagory: catagory);

  factory MLModel.fromJson(Map<String, dynamic> json) {
    return MLModel(
        id: json['id'],
        name: json['name'],
        apiName: json["api_name"],
        learningMethod: json['learning_method'],
        catagory: json['catagory']);
  }
}
