import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/Widget/FeaturetteWidget.dart';
import 'package:trks/Widget/ShopItemWidget.dart';

import '../Models/Models.dart';
import '../Utilities/Utilities.dart';

class RecentsWidget extends StatefulWidget {
  const RecentsWidget({super.key});

  @override
  State<RecentsWidget> createState() => _RecentsWidgetState();
}

class _RecentsWidgetState extends State<RecentsWidget> {
  final ExpandableCarouselController _controller=ExpandableCarouselController();
  List<ShopItem> listRecentShopItems=ShopItemRepository().listRecent;

  @override
  Widget build(BuildContext context) {
    return getCarousel(context);
  }

  Widget getCarousel(BuildContext context){
    return LayoutBuilder(
        builder: (context,size) {
          return SizedBox(
            width: 1210,
            child: Row(
              children: [
                if(listRecentShopItems.length > 3)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 40,
                      height: 50,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          _controller.previousPage();
                        },
                      ),
                    ),
                  ),
                Flexible(
                  child: Column(
                    children: [
                      ExpandableCarousel(
                        items: listRecentShopItems.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                  padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 25),
                                  child: ShopItemWidget(shopItem: i, constraints: size)
                              );
                            },
                          );
                        }).toList(),
                        options: ExpandableCarouselOptions(
                          controller: _controller,
                          showIndicator: size.maxWidth<=900,
                          indicatorMargin: size.maxWidth<=900 ? 10 : 8.0,
                          slideIndicator: size.maxWidth<=900 ? CircularWaveSlideIndicator(
                            slideIndicatorOptions: SlideIndicatorOptions(
                              indicatorBackgroundColor: CustomColors.accentPink,
                              currentIndicatorColor: CustomColors.primaryPink,
                            )
                          ) : null,
                          aspectRatio: 4/5,
                          viewportFraction: size.maxWidth > 900 ? 1/3 : 1/2,
                          padEnds: false,
                          autoPlay: !(size.maxWidth > 900)
                        )
                      ),
                    ],
                  ),
                ),
                if(listRecentShopItems.length > 3)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 40,
                      height: 50,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          _controller.nextPage();
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
    );
  }
}
