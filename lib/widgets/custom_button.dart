import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  VoidCallback onPress;
  final Color color;
  final double borderRadius;
  final double height;

  CustomElevatedButton({Key? key,
    required this.color,
    required this.borderRadius,
    required this.child,
    required this.onPress,
    this.height = 50,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed:onPress,
        child:child,
      ),
    );
  }
}
