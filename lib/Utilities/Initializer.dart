import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Repositories/Repositories.dart';

class Initializer {
  static Future init() async {
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    Random random=Random(1);
    for(Featurette x in FeaturetteRepository().listFeaturettes){
      int i=random.nextInt(25);
      i=i%2;
      ByteData? bytes;
      if(i==1){
        bytes = await rootBundle.load('assets/images/pizza2.jpg');
      } else {
        bytes = await rootBundle.load('assets/images/pizza1.jpg');
      }
      x.image=bytes.buffer.asUint8List();
    }
    SpotlightRepository().listSpotlights.add(Spotlight.getDummy());
    SpotlightRepository().listSpotlights.add(Spotlight.getDummy());
    bool alt=false;
    for(Spotlight x in SpotlightRepository().listSpotlights){
      ByteData? bytes;
      if(alt){
        bytes = await rootBundle.load('assets/images/pizza2.jpg');
      } else {
        bytes = await rootBundle.load('assets/images/pizza1.jpg');
      }
      alt=!alt;
      x.leftImageAlign=alt;
      x.image=bytes.buffer.asUint8List();
    }
  }
}