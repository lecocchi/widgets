import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  color: index == 0
                      ? Colors.transparent
                      : Colors.primaries[index % Colors.primaries.length],
                  child: FittedBox(
                    child:  MyFirstItem(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyFirstItem extends StatefulWidget {
  @override
  _MyFirstItemState createState() => _MyFirstItemState();
}

class _MyFirstItemState extends State<MyFirstItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 3),
      builder: (context, animation, child) => Opacity(
        opacity: animation,
        child: FlutterLogo(),
      ),
      onEnd: () => print('End animation'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
