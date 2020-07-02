import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> names = ['Leandro', 'Guadalupe', 'Santino', 'Julieta'];

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: ReorderableListView(

            children: [
              for (final name in names)
                ListTile(
                  key: ValueKey(name), title: Text(name),)
            ],
            onReorder: (oldIndex, newIndex) {
              print(oldIndex);
              print(newIndex);
            },
          )),
    );
  }
}
