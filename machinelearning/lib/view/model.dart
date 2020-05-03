import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinelearning/model/Example.dart';
import 'package:http/http.dart' as http;
import 'package:machinelearning/model/model.dart';
import 'package:machinelearning/static.dart';

class ModelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ModelPageState();
  }
}

Future<List<Example>> examples(Model model) async {
  String modelName = model.apiName;
  String url = model.type == 'ml' ? mlmodelExamples : dlmodelExamples;
  final response = await http.get(url + modelName);
  Map<String, dynamic> json = jsonDecode(response.body);
  List<dynamic> jsonModels = json['examples'];
  List<Example> examples = new List<Example>();
  for (int i = 0; i < jsonModels.length; i++) {
    Map<String, dynamic> json = jsonModels[i];
    examples.add(Example.fromJson(json));
  }
  return examples;
}

class ModelPageState extends State<ModelPage> {
  @override
  Widget build(BuildContext context) {
    Model model = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                  color: Color.fromRGBO(29, 29, 39, 1),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 2),
                        Text(
                          model.name.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          model.catagory,
                          style: TextStyle(
                              color: Color.fromRGBO(36, 240, 182, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  )),
            ),
            Flexible(
                flex: 11,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CupertinoActivityIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                String name = snapshot.data[index].name.toString().toUpperCase();
                                String catagory = model.catagory;
                                String imgURL;
                                if (catagory == "Classification") {
                                  imgURL = 'images/classification.png';
                                } else if (catagory == "Regression") {
                                  imgURL = 'images/regression.png';
                                } else {
                                  imgURL = 'images/clustering.png';
                                }
                                return Container(
                                    margin: width > height
                                        ? EdgeInsets.fromLTRB(35, 10, 35, 10)
                                        : EdgeInsets.all(10),
                                    height: 150,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.blue,
                                        elevation: 10,
                                        child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Image.asset(
                                                  imgURL,
                                                  scale: 7,
                                                ),
                                                flex: 1,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  name,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                flex: 1,
                                              ),
                                              Flexible(
                                                child: IconButton(
                                                    icon: Icon(
                                                        CupertinoIcons.forward),
                                                    onPressed: () {
                                                      Example example =
                                                          snapshot.data[index];
                                                      example.model =
                                                          model.name;
                                                      example.apiName =
                                                          model.apiName;
                                                      example.type = model.type;
                                                      Navigator.pushNamed(
                                                          context, '/testmodel',
                                                          arguments: snapshot
                                                              .data[index]);
                                                    }),
                                                flex: 1,
                                              )
                                            ],
                                          ),
                                        )));
                              });
                        } else {
                          return Container();
                        }
                      },
                      future: examples(model),
                    ),
                  ),
                )),
          ],
        ));
  }
}
