import 'package:flutter/material.dart';
import 'package:response_website/Utils/SizeScreen.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizeScreen(
          smart: DesktopNavbar(),
          desktop: DesktopNavbar(),
          tablet: DesktopNavbar(),
          phone: MobileNavbar(),
        );
      },
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  final style = TextStyle(color: Colors.white, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('RetroPortal Studio',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30)),
        Row(children: [
          Text('Home', style: style),
          SizedBox(width: 30),
          Text('About Us', style: style),
          SizedBox(width: 30),
          Text('Portfolio', style: style),
          SizedBox(width: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.pink,
            onPressed: () {},
            child: Text('Get Started', style: TextStyle(color: Colors.white)),
          ),
        ]),
      ]),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  final style = TextStyle(color: Colors.white, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Container(
        child: Column(children: [
          Text('RetroPortal Studio',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Home', style: style),
              SizedBox(width: 30),
              Text('About Us', style: style),
              SizedBox(width: 30),
              Text('Portfolio', style: style),
            ]),
          ),
        ]),
      ),
    );
  }
}
