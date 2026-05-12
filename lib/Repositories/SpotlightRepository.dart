import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:trks/Models/Models.dart';

class SpotlightRepository {
  List<Spotlight> listSpotlights=[];

  //#region Singleton Pattern
  static final SpotlightRepository _inst=SpotlightRepository._internal();

  factory SpotlightRepository() {
    return _inst;
  }

  SpotlightRepository._internal();
  //#endregion

  static Future init() async {
    SpotlightRepository().listSpotlights.add(Spotlight.getDummy());
    SpotlightRepository().listSpotlights.add(Spotlight.getDummy());
    bool alt=false;
    Random random=Random(1);
    for(Spotlight x in SpotlightRepository().listSpotlights){
      int i=random.nextInt(25)%3;
      ByteData? bytes;
      if(i==0){
        bytes = await rootBundle.load('assets/images/KS4.jpg');
      } else if (i==2){
        bytes = await rootBundle.load('assets/images/KS3.jpg');
      } else if (i==1){
        bytes = await rootBundle.load('assets/images/KS2.jpg');
      } else {
        bytes = await rootBundle.load('assets/images/KS1.jpg');
      }
      alt=!alt;
      x.leftImageAlign=alt;
      x.image=bytes.buffer.asUint8List();
    }
  }
}