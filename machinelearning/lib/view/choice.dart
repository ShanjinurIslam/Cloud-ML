import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ChoiceListState();
  }
}

class ChoiceListState extends State<ChoiceList> {
  bool screen = true;

  @override
  Widget build(BuildContext context) {
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
                            '16 Models',
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
                    child: Text(screen ? 'ML' : 'DL'),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Container(
                  height: 100,
                  decoration: new BoxDecoration(
                      color: Colors.green, //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.home,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon:
                              Icon(CupertinoIcons.person, color: Colors.white),
                          onPressed: () {}),
                    ],
                  ),
                )),
          ],
        ));
  }
}
