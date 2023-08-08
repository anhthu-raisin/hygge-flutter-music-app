import 'package:flutter/material.dart';

class MyExampleWidget extends StatefulWidget {
  const MyExampleWidget({super.key});

  @override
  State<MyExampleWidget> createState() => _MyExampleWidgetState();
}

class _MyExampleWidgetState extends State<MyExampleWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Card Sample')),
        body: Container(
          child: Material(
            child: InkWell(
              onTap: () {
                print("tapped");
              },
              child: Container(
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
        ));
  }
}
