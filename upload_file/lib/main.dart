import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:upload_file/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('hello-world-html',
        (int viewId) {
      IFrameElement frame = IFrameElement();

      frame.width = '640';
      frame.height = '360';
      frame.src = 'https://www.youtu.com/embed/IyFZznAk69U';
      frame.allowFullscreen = true;
      frame.style.border = 'none';

      frame.onError.first.then((value) => print(value));

      return frame;
    });

    return Center(
      child: Container(
        height: double.infinity,
        // width: 500,
        child: HtmlElementView(
          viewType: 'hello-world-html',
        ),
      ),
    );
  }
}
