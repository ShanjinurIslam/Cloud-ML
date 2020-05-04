import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machinelearning/model/Example.dart';
import 'package:http/http.dart' as http;

import '../static.dart';

class TestModelView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestModelViewState();
  }
}

class TestModelViewState extends State<TestModelView> {
  List<String> xLabel;
  List<String> classes;
  List<TextEditingController> controllers;
  String ylabel;
  String prediction = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void getPrediction(Example example, String data) async {
    String url = example.type == 'ml' ? mltestModel : mltestModel;
    url += example.apiName + '/' + (example.id).toString();
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'data': data}));
    Map<String, dynamic> out = jsonDecode(response.body);
    setState(() {
      prediction = out['prediction'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Example example = ModalRoute.of(context).settings.arguments;
    xLabel = example.xlabels.split(',');
    classes = example.classes.split(',');
    ylabel = example.ylabel;
    controllers =
        new List.generate(xLabel.length, (i) => TextEditingController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: loading
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              child: Container(
                  height: (2) * MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          color: Color.fromRGBO(29, 29, 39, 1),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Spacer(
                                  flex: 2,
                                ),
                                Text(
                                  example.name.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  example.model,
                                  style: TextStyle(
                                      color: Color.fromRGBO(36, 240, 182, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        flex: 2,
                      ),
                      Flexible(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Labels',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Wrap(
                                    children: xLabel
                                        .map(
                                          (String d) => Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            child: Text(d),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  Spacer(),
                                  Text('Target',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  Text(ylabel),
                                  Spacer(),
                                  Text('Classes',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  Wrap(
                                    children: classes
                                        .map(
                                          (String d) => Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            child: Text(d),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  Spacer(),
                                  Text('Accuracy',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  Text(example.accuracy.toString() + '%')
                                ],
                              ),
                            ),
                          ),
                        ),
                        flex: 4,
                      ),
                      Flexible(
                        child: Container(
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Test Model',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: SizedBox(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15) *
                                                xLabel.length,
                                            child: ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: xLabel.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 10),
                                                        child:
                                                            Text(xLabel[index]),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        child: TextField(
                                                          keyboardType: TextInputType
                                                              .numberWithOptions(
                                                                  decimal: true,
                                                                  signed:
                                                                      false),
                                                          controller:
                                                              controllers[
                                                                  index],
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      'Enter Value'),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 0),
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                color: Colors.green,
                                                onPressed: () {
                                                  String data = "";
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  for (int i = 0;
                                                      i < xLabel.length;
                                                      i++) {
                                                    if (controllers[i]
                                                        .text
                                                        .isEmpty) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    } else {
                                                      data +=
                                                          controllers[i].text +
                                                              ',';
                                                      controllers[i].clear();
                                                    }
                                                  }
                                                  data = data.substring(
                                                      0, data.length - 1);

                                                  getPrediction(example, data);
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                },
                                                child: Container(
                                                  width: 100,
                                                  child: Center(
                                                      child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Prediction',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Text(
                                          prediction,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                        flex: 13,
                      ),
                    ],
                  ))),
    );
  }
}
