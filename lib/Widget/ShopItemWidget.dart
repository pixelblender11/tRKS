import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Widget/Widgets.dart';
import 'package:trks/main.dart';

import '../Utilities/Utilities.dart';

class ShopItemWidget extends StatefulWidget {
  final BoxConstraints constraints;
  final ShopItem shopItem;

  const ShopItemWidget({super.key,required this.shopItem,required this.constraints});

  @override
  State<StatefulWidget> createState() => ShopItemWidgetState();
}

class ShopItemWidgetState extends State<ShopItemWidget>{
  @override
  Widget build(BuildContext context) {
    double width=widget.constraints.maxWidth>820 ? (widget.constraints.maxWidth-200-(12.5*3)) / 3: (widget.constraints.maxWidth-12.5*2) / 2;
    if(widget.constraints.maxWidth>820){
      width=Math.max(341, width);
    }
    double height=width+150;
    return InkWell(
      onTap: () async {
        router.go('home/product/${widget.shopItem.pKey}');
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(12.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 0,
            children: [
              SizedBox(
                width: width,
                height: width,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.memory(
                    widget.shopItem.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  widget.shopItem.title,
                  style: Styles.bodyStyle,
                  ),
                ),
              SizedBox(
                height: 32,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    widget.shopItem.priceString,
                    style: Styles.bodyStyle,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}