import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Repositories/Repositories.dart';

class Initializer {
  static Future init() async {
    await FeaturetteRepository.init();
    await SpotlightRepository.init();
    await ShopItemRepository().init();
    ItemCategoryRepository.init();
  }
}