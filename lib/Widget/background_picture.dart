import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class BackgroundBody extends StatelessWidget {
  const BackgroundBody({super.key, required this.child});

 final Widget child;   //Ekta widget child nea asha hoice , karon BackgroundImage constructor e kono default child thake na.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/screen-back.svg',
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        child
      ],
    );
  }
}
