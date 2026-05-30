import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trks/Repositories/Repositories.dart';
import '../../../Models/Models.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void addItemToCart(ShopItem item,int quantity){
    if(ShopItemRepository().listCart.any((x)=>x.pKey==item.pKey)){
      ShopItemRepository().listCart.firstWhere((x)=>x.pKey==item.pKey).qty+=quantity;
    }
    else{
      ShopItemRepository().listCart.add(item);
    }
    ShopItemRepository().listCartVN.value=ShopItemRepository().listCart.toList();
  }
}
