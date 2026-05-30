import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/Widget/FeaturetteWidget.dart';
import 'package:trks/Widget/ShopItemWidget.dart';

import '../Models/Models.dart';
import '../Utilities/Utilities.dart';

class ShopItemCartWidget extends StatefulWidget {
  final ShopItem item;

  const ShopItemCartWidget({super.key,required this.item});

  @override
  State<ShopItemCartWidget> createState() => _ShopItemCartWidgetState();
}

class _ShopItemCartWidgetState extends State<ShopItemCartWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 5,
            child: AspectRatio(
                aspectRatio: 4 / 5,
                child: Image.memory(
                  widget.item.image!,
                  fit: BoxFit.fill,
                )
            ),
          ),
          Flexible(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Center(
                      child: Text(
                        widget.item.title,
                        style: Styles.smallHeaderStyle,
                      )
                    )
                  ),
                  if(widget.item.availableQty>0)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: SizedBox(
                        width: 100,
                        child: InputQty(
                          maxVal: widget.item.availableQty,
                          minVal: 1,
                          initVal: widget.item.qty,
                          steps: 1,
                          onQtyChanged: (val){
                            widget.item.qty=val;
                          },
                        ),
                      ),
                    ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
