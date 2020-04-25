import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:machinelearning/model/ServerStatus.dart';

String url = 'http://192.168.0.106:8000/status';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool flag = false;

  void flagPressed() {
    getServerStatus();
    setState(() {
      flag = !flag;
      print(flag);
    });
  }

  void getServerStatus() async {
    final response = await http.get(url);
    ServerStatus status = responseFromJson(response.body);
    if (status.status == "active") {
      Navigator.pushReplacementNamed(context, '/choicelist');
    } else {
      print('Server is busy. Try Again Later');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: flag
            ? Center(child: CupertinoActivityIndicator())
            : Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                        height: 96,
                        width: width,
                        child: Center(
                          child: Text(
                            'Machine Learning API',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w400),
                          ),
                        )),
                    top: (812 / height) * 218,
                    left: 0,
                    right: 0,
                  ),
                  Positioned(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Color.fromRGBO(147, 120, 255, 1),
                      onPressed: flagPressed,
                      child: Container(
                        height: (812 / height) * 54,
                        width: (375 / width) * 263,
                        child: Center(
                          child: Text(
                            'Begin',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    top: (812 / height) * 602,
                    left: (375 / width) * 56,
                  ),
                ],
              ));
  }
}
