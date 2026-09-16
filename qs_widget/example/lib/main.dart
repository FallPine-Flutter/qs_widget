import 'package:flutter/material.dart';
import 'package:qs_widget/qs_box.dart';
import 'package:qs_widget/qs_label.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('qs_widget example')),
        body: const Center(
          child: QsBox(
            padding: EdgeInsetsDirectional.all(16),
            color: Colors.blue,
            outerRadius: BorderRadiusDirectional.all(Radius.circular(12)),
            child: QsLabel(
              text: 'qs_widget',
              textColor: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
