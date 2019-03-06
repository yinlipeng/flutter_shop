import 'package:flutter/material.dart';
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('button'),),
      body: Align(
        alignment: Alignment.bottomCenter,
        widthFactor: 2.0,
        heightFactor: 2.0,
        child: Container(
          width: 50,
          height: 50,
          color: Colors.blue,
            child: Text("Align")),
      ),
    );
  }
}


class MyTest extends StatelessWidget {
  final List<String> items;

  MyTest({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return  Scaffold(

        body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return new Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify Widgets.
              key: new Key(item),
              // We also need to provide a function that will tell our app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                items.removeAt(index);

                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text("$item dismissed")));
              },
              // Show a red background as the item is swiped away
              background: new Container(color: Colors.red),
              child: new ListTile(title: new Text('$item')),
            );
          },
        ),
      );

  }
}