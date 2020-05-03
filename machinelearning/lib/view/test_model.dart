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
  String ylabel;
  String input = "";
  int current;
  String prediction = "";
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    current = 0;
  }

  void getPrediction(Example example, String data) async {
    String url = example.type == 'ml' ? mltestModel : mltestModel;
    url += example.apiName + '/' + (example.id).toString();
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{'data': data})
    );
    Map<String, dynamic> out = jsonDecode(response.body);
    setState(() {
      prediction = out['prediction'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    Example example = ModalRoute.of(context).settings.arguments;
    xLabel = example.xlabels.split(',');
    int len = xLabel.length;
    classes = example.classes.split(',');
    ylabel = example.ylabel;
    String data;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: loading
          ? Center(child: CupertinoActivityIndicator())
          : Column(
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
                            'IRIS',
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
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Wrap(
                              children: xLabel
                                  .map(
                                    (String d) => Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(d),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Spacer(),
                            Text('Target',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Text(ylabel),
                            Spacer(),
                            Text('Classes',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Wrap(
                              children: classes
                                  .map(
                                    (String d) => Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: Text(d),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  flex: 3,
                ),
                Flexible(
                  child: Container(
                      child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Test Model',
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: TextField(
                                    controller: controller,
                                    onChanged: (text) {
                                      data = text;
                                    },
                                    decoration: InputDecoration(
                                      hintText: xLabel[current],
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Center(
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          color: Colors.green,
                                          onPressed: () {
                                            if (current < len - 1) {
                                              input += data + ',';
                                              controller.clear();
                                            } else {
                                              input += data;
                                              setState(() {
                                                prediction = "";
                                                loading = true;
                                              });
                                              getPrediction(example, input);
                                              input = "";
                                              controller.clear();
                                            }
                                            setState(() {
                                              current = (current + 1) % 4;
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            child: Center(
                                                child: Text(
                                              current < len - 1
                                                  ? 'Next'
                                                  : 'Submit',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Prediction',
                                  style: TextStyle(fontSize: 24),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Text(
                                    prediction,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                  flex: 8,
                ),
              ],
            ),
    );
  }
}
