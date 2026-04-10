import 'package:flutter/material.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Widget/Widgets.dart';

import '../Utilities/Utilities.dart';

class SpotlightWidget extends StatelessWidget {
  final Spotlight spotlight;

  const SpotlightWidget({super.key,required this.spotlight});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        if(size.maxWidth >= 700){
          return getHorizontalLayout(context);
        }
        else {
          return getVerticalLayout(context);
        }
      }
    );
  }

  Widget getHorizontalLayout(BuildContext context){
    return SizedBox(
      width: 900,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(spotlight.image!=null && spotlight.leftImageAlign)
            Flexible(
              flex: 5,
              child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Image.memory(
                    spotlight.image!,
                    fit: BoxFit.fill,
                  )
              ),
            ),
          Flexible(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Center(
                          child: Text(
                            spotlight.title,
                            style: Styles.headerStyle,
                          )
                      )
                  ),
                  Flexible(
                      child: Text(
                        spotlight.description,
                        style: Styles.bodyStyle,
                      )
                  ),
                  if(spotlight.url.isNotEmpty)
                    Align(
                      alignment: AlignmentGeometry.bottomCenter,
                      child: KSbutton(
                          label: spotlight.buttonText,
                          onPressed: () {

                          }
                      ),
                    )
                ],
              ),
            ),
          ),
          if(spotlight.image!=null && !spotlight.leftImageAlign)
            Flexible(
              flex: 5,
              child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Image.memory(
                    spotlight.image!,
                    fit: BoxFit.fill,
                  )
              ),
            ),
        ],
      ),
    );
  }

  Widget getVerticalLayout(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: Center(
                        child: Text(
                          spotlight.title,
                          style: Styles.headerStyle,
                        )
                    )
                ),
                Flexible(
                    child: Text(
                      spotlight.description,
                      style: Styles.bodyStyle,
                    )
                ),
                if(spotlight.url.isNotEmpty)
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: KSbutton(
                        label: spotlight.buttonText,
                        onPressed: () {

                        }
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

}