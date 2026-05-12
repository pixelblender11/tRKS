part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {
  final List<ShopItem> listMerchItems;
  final List<ShopItem> listMemorabiliaItems;
  final List<ItemCategory> listItemCategory;
  final SortBy orderBy;
  final int categoryKey;
  final int index;
  final int totalIndexes;

  ShopInitial({
    required this.listMerchItems,
    required this.listMemorabiliaItems,
    required this.index,
    required this.totalIndexes,
    required this.listItemCategory,
    this.orderBy=SortBy.None,
    this.categoryKey=-1,
  });
}
