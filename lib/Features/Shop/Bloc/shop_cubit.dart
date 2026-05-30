
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:trks/Repositories/Repositories.dart';

import '../../../Models/Models.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  int pageSize=12;
  int pageIndex=1;

  ShopCubit() : super(
      ShopInitial(
          listMerchItems: ShopItemRepository().listShopItems.where((x)=>x.categoryKey.contains(1)).take(12).toList(),
          listMemorabiliaItems: ShopItemRepository().listShopItems.where((x)=>!x.categoryKey.contains(1)).toList(),
          index: 1,
          totalIndexes: (ShopItemRepository().listShopItems.length/12).ceil(),
          listItemCategory: ItemCategoryRepository().listCategories,
      )
  );

  Future onSearchOrFilter(String searchText, int categoryKey,SortBy sortBy) async {
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
    var retVal=ShopItemRepository().listShopItems
      .where(
        (x) {
          return (x.categoryKey.contains(categoryKey) || categoryKey==-1)
              && (x.title.toLowerCase().contains(searchText.toLowerCase()) || searchText.isEmpty);
        }
      )
      .take(pageSize*pageIndex)
      .toList();
    emit(ShopInitial(
      listMerchItems: retVal,
      listMemorabiliaItems: categoryKey==-1 ? ShopItemRepository().listShopItems.where((x)=>!x.categoryKey.contains(1)).toList() : [],
      index: pageIndex,
      totalIndexes: (retVal.length/pageSize).ceil(),
      listItemCategory: ItemCategoryRepository().listCategories,
      categoryKey: categoryKey,
      orderBy: sortBy
    ));
  }
}
