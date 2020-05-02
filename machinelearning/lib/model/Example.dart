import 'dart:convert';

class Example {
  final int id;
  final String name;
  final String xlabels ;
  final String ylabel ;
  final String classes ;

  Example({this.id, this.name,this.xlabels,this.ylabel,this.classes});

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(
      id: json['id'],
      name: json['name'],
      xlabels: json['xlabels'],
      ylabel: json['ylabel'],
      classes: json['classes'],
    );
  }
}
