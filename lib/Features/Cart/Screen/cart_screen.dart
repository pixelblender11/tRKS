import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    double quantity=ShopItemRepository().listCart.fold<double>(0, (sum,element)=>sum+(element.qty));
    double total=ShopItemRepository().listCart.fold<double>(0, (sum,element)=>sum+(element.price*element.qty));
    String formattedPrice = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 2,
    ).format(total);
    return Drawer(
      width: 500,
      child: BlocProvider(
        create: (context)=>CartCubit(),
        child: BlocConsumer<CartCubit,CartState>(
          builder: (context, state) {
            if(ShopItemRepository().listCart.isEmpty){
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  spacing: 40,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Cart ($quantity)",
                          style: Styles.smallHeaderStyle,
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)
                        )
                      ],
                    ),
                    Text(
                      "Your cart is currently empty.",
                      style: Styles.bodyStyle,
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 40,
                children: [
                  Row(
                    children: [
                      Text(
                        "Cart ($quantity)",
                        style: Styles.smallHeaderStyle,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,0,5),
                      child: ListView.builder(
                        itemCount: ShopItemRepository().listCart.length,
                        itemBuilder: (context, index) {
                          ShopItem item=ShopItemRepository().listCart[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0,5,0,5),
                            child: GlassConversion.defaultAsGlass(
                              ShopItemCartWidget(item: item)
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "SUBTOTAL",
                        style: Styles.bodyStyle,
                      ),
                      Spacer(),
                      Text(
                        formattedPrice,
                        style: Styles.bodyStyle,
                      ),
                    ],
                  ),
                  Text(
                    "Shipping and taxes calculated at checkout.",
                    style: Styles.bodyStyle,
                  ),
                  KSbutton(onPressed: () {},label: "Check Out",)
                ],
              ),
            );
          },
          listener: (context, state) {

          }
        ),
      ),
    );
  }
}