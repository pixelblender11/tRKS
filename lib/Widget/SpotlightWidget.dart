import 'package:flutter/material.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Widget/Widgets.dart';

class SpotlightWidget extends StatelessWidget {
  final Spotlight spotlight;

  const SpotlightWidget({super.key,required this.spotlight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        if(spotlight.image!=null && spotlight.leftImageAlign)
          Flexible(
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.memory(
                spotlight.image!,
                fit: BoxFit.fill,
              )
            ),
          ),
        Flexible(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Flexible(
               child: Center(
                 child: Text(
                   spotlight.title,
                   style: TextStyle(
                     fontSize: 32
                   ),
                 )
               )
             ),
             Flexible(child: Text(spotlight.description)),
             if(spotlight.url.isNotEmpty)
               Center(
                 child: KSbutton(
                   label: spotlight.buttonText,
                   onPressed: () {
                 
                   }
                 ),
               )
           ],
         ),
        ),
        if(spotlight.image!=null && !spotlight.leftImageAlign)
          Flexible(
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.memory(
                spotlight.image!,
                fit: BoxFit.fill,
              )
            ),
          ),
     ],
    );
  }

}