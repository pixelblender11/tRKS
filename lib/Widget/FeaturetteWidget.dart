import 'package:flutter/material.dart';
import 'package:trks/Utilities/Utilities.dart';
import '../Models/Models.dart';

class FeaturetteWidget extends StatelessWidget{
  final Featurette featured;

  const FeaturetteWidget({super.key,required this.featured});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {

      },
      child: GlassConversion.defaultAsGlass(
        Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.memory(
                featured.image!,
                fit: BoxFit.fill,
              ),
            ),
            if(featured.description.isNotEmpty)
              Text(featured.description),
          ],
        ),
      ),
    );
  }
}