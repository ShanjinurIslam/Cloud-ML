import 'package:flutter/cupertino.dart';
import 'package:machinelearning/view/choice.dart';
import 'package:machinelearning/view/home.dart';
import 'package:machinelearning/view/model.dart';
import 'package:machinelearning/view/test_model.dart';

final routes = {
  '/': (BuildContext context) => new MyHomePage(),
  '/choicelist': (BuildContext context) => new ChoiceList(),
  '/model': (BuildContext context) => new ModelPage(),
  '/testmodel': (BuildContext context) => TestModelView()
};
