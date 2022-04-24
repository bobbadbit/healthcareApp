import 'package:air_quality_application/utils/styleguides/colors.dart';
import 'package:flutter/material.dart';
class OptionBox extends StatelessWidget {
  final String text;
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  Color? color;
  double elevation;
  OptionBox(
      {Key? key,
      required this.child,
      this.text = "",
      this.onPressed,
      this.color,
      this.elevation = 5.0,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
          backgroundColor: MaterialStateProperty.all<Color>(color ?? lightBlueGradientColor),
          // overlayColor: MaterialStateProperty.all(Colors.white.with),
          elevation: MaterialStateProperty.all<double>(elevation),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
