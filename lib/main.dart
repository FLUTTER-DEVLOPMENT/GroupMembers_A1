import 'package:flutter/material.dart';
import 'package:group_members/ui/screens/HomeScreen.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'constant.dart';

void main() {
  Parse().initialize(
    kApplicationId,
    kServerUrl,
  ); // initializing parse server for using services of parse
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Members',
      home: HomeScreen(),
    );
  }
}
