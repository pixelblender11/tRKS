import 'package:trks/Models/Models.dart';

class ItemCategoryRepository {
  List<ItemCategory> listCategories=[];

  //#region Singleton Pattern
  static final ItemCategoryRepository _inst=ItemCategoryRepository._internal();

  factory ItemCategoryRepository() {
    return _inst;
  }

  ItemCategoryRepository._internal();
  //#endregion

  static Future init({List<ItemCategory>? listCategories}) async {
    ItemCategoryRepository().listCategories.add(ItemCategory(key: -1, description: "None"));
    ItemCategoryRepository().listCategories.add(ItemCategory(key: 0, description: "Memorobillia"));
    ItemCategoryRepository().listCategories.add(ItemCategory(key: 1, description: "Merch"));
    ItemCategoryRepository().listCategories.add(ItemCategory(key: 2, description: "Peperoni"));
  }
}