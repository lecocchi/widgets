import 'package:flutter/material.dart';
import 'package:response_website/LandingPage/LandingPage.dart';
import 'package:response_website/Navbar/navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(195, 20, 50, 1.0),
                    Color.fromRGBO(36, 11, 54, 1.0)
                  ]),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                NavBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 40.0),
                  child: LandingPage(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
