import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Repositories/Repositories.dart';

class ShopItemRepository extends RepositoryBase {
  List<ShopItem> listShopItems=[];
  ValueNotifier<List<ShopItem>> listCartVN=ValueNotifier([]);
  List<ShopItem> get listCart {
    return listCartVN.value;
  }
  List<ShopItem> listRecent=[];

  //#region Singleton Pattern
  static final ShopItemRepository _inst=ShopItemRepository._internal();

  factory ShopItemRepository() {
    return _inst;
  }

  ShopItemRepository._internal();
  //#endregion

  Future init({List<ShopItem>? listShopItems, List<ShopItem>? listCard}) async {
    for(int y=0;y<100;y++){
      ShopItem item=ShopItem.getDummy(isMerch: (y%2)==1);
      while(ShopItemRepository().listShopItems.any((x)=>x.pKey==item.pKey)){
        item=ShopItem.getDummy(isMerch: (y%2)==1);
      }
      ShopItemRepository().listShopItems.add(item);
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
    super.init();
  }

  void updateRecent(ShopItem shopItem) {
    if(listRecent.any((x)=>x.pKey==shopItem.pKey)){
      listRecent.sort((x,y) {
        return x.pKey==shopItem.pKey ? 1 : 0;
      });
    }
    else {
      listRecent.insert(0,shopItem);
    }
  }
}