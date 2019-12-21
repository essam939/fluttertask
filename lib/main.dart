import 'package:flutter/material.dart';
import 'package:mytask/provider/mainProvider.dart';
import 'package:provider/provider.dart';

import 'Screens/homePage.dart';

void main() => runApp(ChangeNotifierProvider<MainProvider>(create: (context){
  return MainProvider();
},
    child: MyApp()));

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Color mainColor = Color(0xffb74093);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(length: 2,child: HomePage()),
    );
  }
}



