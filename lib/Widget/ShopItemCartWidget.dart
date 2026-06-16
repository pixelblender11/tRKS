import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';

import '../Models/Models.dart';
import '../Repositories/Repositories.dart';
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
    String formattedPrice = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 2,
    ).format(widget.item.price);
    return SizedBox(
      width: 500,
      height: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Image.memory(
                    widget.item.image!,
                    fit: BoxFit.fill,
                  )
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Expanded(
                    child: Text(
                      widget.item.title,
                      style: Styles.bodyStyle,
                    )
                  ),
                  Spacer(),
                  Row(
                    children: [
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
                              decoration: QtyDecorationProps(
                                btnColor: CustomColors.accentPink,
                                borderShape: BorderShapeBtn.circle,
                                isBordered: false
                              ),
                              qtyFormProps: QtyFormProps(
                                enableTyping: false,
                              ),
                              onQtyChanged: (val){
                                widget.item.qty=val;
                                ShopItemRepository().listCartVN.value=ShopItemRepository().listCart.toList();
                              },
                            ),
                          ),
                        ),
                      Spacer(),
                      Text(
                        formattedPrice,
                        style: Styles.bodyStyle,
                      )
                    ],
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
