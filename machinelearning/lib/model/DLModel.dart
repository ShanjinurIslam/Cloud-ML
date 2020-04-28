class DLModel {
  final int id;
  final String name;
  final String useCase;
  final String catagory;

  DLModel({this.id, this.name, this.useCase, this.catagory});

  factory DLModel.fromJson(Map<String, dynamic> json) {
    return DLModel(
        id: json['id'],
        name: json['name'],
        useCase: json['use_case'],
        catagory: json['catagory']);
  }
}
