import 'package:flutter/material.dart';
import 'package:glass/glass.dart';

class GlassConversion {
  static Widget defaultAsGlass(Widget widget){
    return widget.asGlass(
        frosted: false,
        tintColor: Colors.pink,//Color.fromARGB(255, 255, 183, 213),
        clipBorderRadius: BorderRadius.circular(15.0),
        blurX: 10,
        blurY: 10,
        tileMode: TileMode.decal
    );
  }
}