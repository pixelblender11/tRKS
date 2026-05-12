import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:trks/Models/Models.dart';

class FeaturetteRepository {
  List<Featurette> listFeaturettes=[];

  //#region Singleton Pattern
  static final FeaturetteRepository _inst=FeaturetteRepository._internal();

  factory FeaturetteRepository() {
    return _inst;
  }

  FeaturetteRepository._internal();
  //#endregion

  static Future init() async {
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    FeaturetteRepository().listFeaturettes.add(Featurette.getDummy());
    Random random=Random(1);
    for(Featurette x in FeaturetteRepository().listFeaturettes){
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
      x.image=bytes.buffer.asUint8List();
    }
  }
}