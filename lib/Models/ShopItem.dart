import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Repositories/Repositories.dart';

class ShopItem{
  int pKey=-1;
  String title="";
  String description="";
  String tags="";
  double price=0;
  double discount=0;
  int quantity=-1;
  Uint8List? image;
  DateTime dateAdded=DateTime.now();
  List<int> categoryKey=[];

  String get priceString {
    String formattedPrice = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 2,
    ).format(price);
    return formattedPrice;
  }

  List<ItemCategory> get categories {
    return ItemCategoryRepository().listCategories.where((x)=>categoryKey.contains(x.key)).toList();
  }

  ShopItem();

  ShopItem.getDummy({bool isMerch=false}){
    pKey=Random().nextInt(99);
    description="Here is some dummy text explaining the details of a product. Products are interesting. Products are for selling. Buy the product now";
    price=Random().nextDouble()*256;
    title="Product Title of a Thing";
    categoryKey.add((Random().nextInt(9999)%3));
    if(!isMerch && !categoryKey.contains(0)){
      categoryKey.add(1);
    }
  }
}