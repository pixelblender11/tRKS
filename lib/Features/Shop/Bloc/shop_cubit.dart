
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:trks/Repositories/Repositories.dart';

import '../../../Models/Models.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  static int pageSize=12;
  static int pageIndex=1;

  ShopCubit() : super(
      ShopInitial(
          listMerchItems: ShopItemRepository().listShopItems.where((x)=>x.categoryKey.contains(1)).take(pageSize).toList(),
          listMemorabiliaItems: ShopItemRepository().listShopItems.where((x)=>!x.categoryKey.contains(1)).toList(),
          index: 1,
          totalIndexes: (ShopItemRepository().listShopItems.length/pageSize).ceil(),
          listItemCategory: ItemCategoryRepository().listCategories,
      )
  );

  Future onSearchOrFilter(String searchText, int categoryKey,SortBy sortBy,{int pageNextIndex=1}) async {
    //If the category key is -2, then we're doing a 'preview' page / initial state. This will simply display Merch and Memorobelia at the same time.
    if(categoryKey==-2){
      emit(ShopInitial(
        listMerchItems: ShopItemRepository().listShopItems.where((x)=>x.categoryKey.contains(1)).take(pageSize).toList(),
        listMemorabiliaItems: ShopItemRepository().listShopItems.where((x)=>!x.categoryKey.contains(1)).toList(),
        index: 1,
        totalIndexes: (ShopItemRepository().listShopItems.length/pageSize).ceil(),
        listItemCategory: ItemCategoryRepository().listCategories,
      ));
      return;
    }
    ShopItemRepository().listShopItems.sort(
        (a,b) {
          if(sortBy==SortBy.None){
            return 0;
          }
          else if(sortBy==SortBy.HighToLow){
            return b.price.compareTo(a.price);
          }
          else if(sortBy==SortBy.LowToHigh){
            return a.price.compareTo(b.price);
          }
          else if(sortBy==SortBy.Newest){
            return a.dateAdded.compareTo(b.dateAdded);
          }
          else {
            return b.dateAdded.compareTo(a.dateAdded);
          }
        }
      );
    //Get the page for the cieling and floor (this will be replaced with a network call).
    var retVal=ShopItemRepository().listShopItems
      .where(
        (x) {
          return (x.categoryKey.contains(categoryKey) || categoryKey==-1)
              && (x.title.toLowerCase().contains(searchText.toLowerCase()) || searchText.isEmpty);
        }
      );
    //Cap the cieling and floor
    int index=max(1,pageNextIndex);
    int totalPages=(retVal.length/pageSize).ceil();
    index=min(index,totalPages);
    retVal=retVal.skip(max(0,index-1)*pageSize)
      .take(pageSize)
      .toList();
    //Display filtered page on the given index.
    emit(ShopInitial(
      listMerchItems: retVal.toList(),
      listMemorabiliaItems: categoryKey==-1 ? ShopItemRepository().listShopItems.where((x)=>!x.categoryKey.contains(1)).toList() : [],
      index: index,
      totalIndexes: totalPages,
      listItemCategory: ItemCategoryRepository().listCategories,
      categoryKey: categoryKey,
      orderBy: sortBy
    ));
  }
}
