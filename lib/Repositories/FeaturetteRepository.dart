import 'package:trks/Models/Models.dart';

class FeaturetteRepository {
  List<Featurette> listFeaturettes=[];

  //#region Singleton Pattern
  static final FeaturetteRepository _inst=FeaturetteRepository._internal();

  factory FeaturetteRepository() {
    return _inst;
  }
  //#endregion

  FeaturetteRepository._internal();
}