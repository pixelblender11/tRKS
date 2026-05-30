import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trks/Features/Cart/Bloc/cart_cubit.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/Utilities/Utilities.dart';
import 'package:trks/Features/Features.dart';
import 'package:trks/Widget/Widgets.dart';
import 'package:trks/main.dart';
import 'package:web/web.dart' as web;

import '../../../Models/Models.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 500,
      child: BlocProvider(
        create: (context)=>CartCubit(),
        child: BlocConsumer<CartCubit,CartState>(
          builder: (context, state) {
            return ListView.builder(
                itemCount: ShopItemRepository().listCart.length,
                itemBuilder: (context, index) {
                  ShopItem item=ShopItemRepository().listCart[index];
                  return ShopItemCartWidget(item: item);
                }
            );
            return Column(
              children: [
                Container(
                  color: Colors.blue,
                  child: Text("Hi"),
                ),

              ],
            );
          },
          listener: (context, state) {

          }
        ),
      ),
    );
  }
}