import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({
    Key key,
  }) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double start;
  double end;

  @override
  void initState() {
    super.initState();
    start = 0.0;
    end = 2 * pi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: start, end: end),
          child: Image.asset(
            'assets/coin.jpg',
            width: 300,
          ),
          duration: const Duration(seconds: 3),
          builder: (context, value, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(value),
              child: child,
            );
          },
          onEnd: () {
            setState(() {
              end = end == 0.0 ? 2 * pi : 0.0;
            });
          },
        ),
      ),
    );
  }
}
