class MLModel {
  final int id;
  final String name;
  final String learningMethod;
  final String catagory;

  MLModel({this.id, this.name, this.learningMethod, this.catagory});

  factory MLModel.fromJson(Map<String, dynamic> json) {
    return MLModel(
        id: json['id'],
        name: json['name'],
        learningMethod: json['learning_method'],
        catagory: json['catagory']);
  }
}
