import 'package:flutter/material.dart';
import 'package:response_website/Utils/SizeScreen.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizeScreen(
        smart: LandingPageDesktop(constraints.biggest.width / 2),
        desktop: LandingPageDesktop(constraints.biggest.width / 2),
        tablet: LandingPageDesktop(constraints.biggest.width / 2),
        phone: LandingPageMobile(constraints.biggest.width),
      ),
    );
  }
}

class LandingPageDesktop extends StatelessWidget {
  final double width;

  const LandingPageDesktop(this.width);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: width,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Website \nDevelopers',
              style: TextStyle(fontSize: 40, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
                'We have taken each and every project handed over to us as a challenge, which has helped us achieve a high project success rate.',
                style: TextStyle(color: Colors.white)),
          ),
          MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text('Our Packages', style: TextStyle(color: Colors.red)),
            onPressed: () {},
          )
        ]),
      ),
      Image.asset(
        'assets/images/lp_image.png',
        width: width,
      ),
    ]);
  }
}

class LandingPageMobile extends StatelessWidget {
  final double width;

  const LandingPageMobile(this.width);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
