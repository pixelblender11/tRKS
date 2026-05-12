import 'package:flutter/material.dart';
import 'package:trks/Utilities/Utilities.dart';
import '../Models/Models.dart';

class FeaturetteWidget extends StatelessWidget{
  final Featurette featured;
  final double aspectRatio;

  const FeaturetteWidget({super.key,required this.featured,this.aspectRatio=4/5});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {

      },
      child: GlassConversion.defaultAsGlass(
        GestureDetector(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Image.memory(
                  featured.image!,
                  fit: BoxFit.cover,
                ),
              ),
              if(featured.description.isNotEmpty)
                Text(featured.description),
            ],
          ),
        ),
      ),
    );
  }
}