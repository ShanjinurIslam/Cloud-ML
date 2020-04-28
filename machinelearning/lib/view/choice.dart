import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machinelearning/model/DLModel.dart';
import 'package:machinelearning/model/MLModel.dart';

String mlModelsURL =
    "http://192.168.0.106:8000/ml/models"; //subject to change depending on ip address
String dlModelsURL = "http://192.168.0.106:8000/dl/models";

class ChoiceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ChoiceListState();
  }
}

class ChoiceListState extends State<ChoiceList> {
  bool screen = true;

  Future<List<MLModel>> mlModels() async {
    final response = await http.get(mlModelsURL);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> jsonModels = json['models'];
    List<MLModel> mlModels = new List<MLModel>();

    for (int i = 0; i < jsonModels.length; i++) {
      Map<String, dynamic> json = jsonModels[i];
      mlModels.add(MLModel.fromJson(json));
    }
    return mlModels;
  }

  Future<List<DLModel>> dlModels() async {
    final response = await http.get(dlModelsURL);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> jsonModels = json['models'];
    List<DLModel> dlModels = new List<DLModel>();

    for (int i = 0; i < jsonModels.length; i++) {
      Map<String, dynamic> json = jsonModels[i];
      dlModels.add(DLModel.fromJson(json));
    }
    return dlModels;
  }

  @override
  Widget build(BuildContext context) {
    int number = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Container(
                  color: Color.fromRGBO(29, 29, 39, 1),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Available Models'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            number.toString()+' Models',
                            style: TextStyle(
                                color: Color.fromRGBO(36, 240, 182, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                screen = true;
                              });
                            },
                            child: Center(
                                child: Text(
                              'Machine Learning',
                              style: TextStyle(
                                  fontWeight: screen
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            )),
                          )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            screen = false;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                              child: Text(
                            'Deep Learning',
                            style: TextStyle(
                                fontWeight: !screen
                                    ? FontWeight.w600
                                    : FontWeight.w400),
                          )),
                        ),
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 10,
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
                                String name = snapshot.data[index].name;
                                String catagory = snapshot.data[index].catagory;
                                String imgURL;
                                if (catagory == "Classification") {
                                  imgURL = 'images/classification.png';
                                } else if (catagory == "Regression") {
                                  imgURL = 'images/regression.png';
                                } else {
                                  imgURL = 'images/clustering.png';
                                }
                                return Container(
                                    margin: EdgeInsets.all(10),
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
                                                    onPressed: null),
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
                      future: screen ? mlModels() : dlModels(),
                    ),
                  ),
                )),
          ],
        ));
  }
}
