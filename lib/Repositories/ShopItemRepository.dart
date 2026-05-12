import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:trks/Models/Models.dart';

class ShopItemRepository {
  List<ShopItem> listShopItems=[];
  List<ShopItem> listCart=[];

  //#region Singleton Pattern
  static final ShopItemRepository _inst=ShopItemRepository._internal();

  factory ShopItemRepository() {
    return _inst;
  }

  ShopItemRepository._internal();
  //#endregion

  static Future init({List<ShopItem>? listShopItems, List<ShopItem>? listCard}) async {
    for(int y=0;y<100;y++){
      ShopItemRepository().listShopItems.add(ShopItem.getDummy(isMerch: (y%2)==1));
    }
    int i=0;
    for(ShopItem x in ShopItemRepository().listShopItems){
      ByteData? bytes;
      if(i==0){
        bytes = await rootBundle.load('assets/images/KS4.jpg');
      } else if (i==2){
        bytes = await rootBundle.load('assets/images/KS3.jpg');
      } else if (i==1){
        bytes = await rootBundle.load('assets/images/KS2.jpg');
      } else {
        bytes = await rootBundle.load('assets/images/KSa1.jpg');
      }
      i=(i+1)%3;
      x.image=bytes.buffer.asUint8List();
    }
  }
}