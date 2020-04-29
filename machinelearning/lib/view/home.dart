import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:machinelearning/model/ServerStatus.dart';
import 'package:machinelearning/view/choice.dart';

import '../static.dart';

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
    });
  }

  Future<void> _handleClickMe() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Can not connect to server'),
          content: Text('Server may be down or an update may be going on'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getServerStatus() async {
    http.Response response;
    try {
      response = await http.get(statusUrl).timeout(const Duration(seconds: 2));
    } on TimeoutException catch (_) {
      setState(() {
        flag = false;
      });
      _handleClickMe();
    }
    ServerStatus status = ServerStatus.fromJson(jsonDecode(response.body));
    if (status.status == "active") {
      Navigator.of(context).pushReplacement(new PageRouteBuilder(
          pageBuilder: (BuildContext context, _, __) {
        return new ChoiceList();
      }, transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
        return new FadeTransition(opacity: animation, child: child);
      }));
    } else {
      return _handleClickMe();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: flag
            ? Center(child: CupertinoActivityIndicator())
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                        child: Center(
                      child: Text(
                        'Cloud ML',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w400),
                      ),
                    )),
                    Flexible(child: Image.asset('images/ml.png',scale: 2,),flex: 10,),
                    Flexible(
                      flex: 1,
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
                    ))
                  ],
                ),
              ));
  }
}