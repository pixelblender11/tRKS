import 'package:trks/Models/Models.dart';

class SpotlightRepository {
  List<Spotlight> listSpotlights=[];

  //#region Singleton Pattern
  static final SpotlightRepository _inst=SpotlightRepository._internal();

  factory SpotlightRepository() {
    return _inst;
  }
  //#endregion

  SpotlightRepository._internal();
}