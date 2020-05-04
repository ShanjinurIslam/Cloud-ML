import 'dart:convert';

class Example {
  final int id;
  final String name;
  final String xlabels;
  final String ylabel;
  final String classes;
  final double accuracy;
  String model;
  String apiName;
  String type;

  Example({this.id, this.name, this.xlabels, this.ylabel, this.classes,this.accuracy});

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      id: json['id'],
      name: json['name'],
      xlabels: json['xlabels'],
      ylabel: json['ylabel'],
      classes: json['classes'],
      accuracy: json['accuracy']
    );
  }
}
