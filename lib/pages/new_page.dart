import 'package:flutter/material.dart';
class NewPageTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试页'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.blue,
          child: Center(
            child:Text('haha')
          ),
        ),
      ),
    );
  }
}
