import 'package:flutter/material.dart';

import '../Utilities/Utilities.dart';

class KSbutton extends StatelessWidget{
  void Function() onPressed;
  String label;
  double width;
  double height;
  bool alternativeColor;

  KSbutton({
    super.key,
    required this.onPressed,
    this.label="",
    this.width=135,
    this.height=45,
    this.alternativeColor=false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: WidgetStateColor.resolveWith((a) {return alternativeColor ? CustomColors.backgroundPink : CustomColors.accentPink;}),
          backgroundColor: WidgetStateColor.resolveWith((a) {return alternativeColor ? CustomColors.backgroundPink : CustomColors.accentPink;}),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: alternativeColor ? CustomColors.accentPink : Colors.white
          ),
        ),
      ),
    );
  }


}