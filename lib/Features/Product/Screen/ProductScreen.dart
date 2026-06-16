import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:trks/Features/Product/Bloc/product_cubit.dart';
import 'package:trks/Models/Models.dart';
import 'package:intl/intl.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/main.dart';
import '../../../Utilities/Utilities.dart';
import '../../../Widget/Widgets.dart';
import '../../Features.dart';

class ProductScreen extends StatefulWidget {
  final ShopItem shopItem;

  const ProductScreen({super.key,required this.shopItem});

  @override
  State<StatefulWidget> createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen>{
  TextEditingController searchBarController=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();

  int quantity=1;

  @override void dispose() {
    ShopItemRepository().updateRecent(widget.shopItem);
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/kendra-bg1.jpg"),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter
        ),
        color: CustomColors.backgroundPink
      ),
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        endDrawer: CartScreen(),
        endDrawerEnableOpenDragGesture: false,
        appBar: AppBar(
          automaticallyImplyActions: false, // Hides the default back button
          automaticallyImplyLeading: false, // Hides the default back button
          backgroundColor: Colors.transparent,
          title: Center(
            child: SizedBox(
              width: 1100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                spacing: 5,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 47,
                      width: 47,
                      child: GlassConversion.defaultAsGlass(
                        GestureDetector(
                          onTap: () {
                            router.pop();
                          },
                          child: Container(
                            child: Image.asset(
                              'assets/images/kendra_seunderland_logox2.png',
                              fit: BoxFit.contain,
                              height: AppBar().preferredSize.height,
                            ),
                          ),
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      minLines: 1,
                      controller: searchBarController,
                      onFieldSubmitted: (value) {
                        router.go('/home?searchText=${searchBarController.text}');
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  GlassConversion.defaultAsGlass(
                    ValueListenableBuilder(
                      valueListenable: ShopItemRepository().listCartVN,
                      builder: (context, value, child) {
                        double quantity=ShopItemRepository().listCart.fold<double>(0, (sum,element)=>sum+(element.qty));
                        return SizedBox(
                          width: 45,
                          height: 45,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                      ),
                                    ),
                                    if(ShopItemRepository().listCart.isNotEmpty)
                                      Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                            width: 13,
                                            height: 13,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              quantity.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                      ),
                                  ],
                                ),
                                onTap: () {
                                  _scaffoldKey.currentState!.openEndDrawer();
                                }
                            ),
                          ),
                        );
                      }
                    )
                  )
                ],
              ),
            )
          ),
        ),
        body: BlocProvider(
          create: (context) => ProductCubit(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: LayoutBuilder(
                builder: (context,screenSize) {
                  return Container(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 1100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if(screenSize.maxWidth>900)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 3,
                                      child: LayoutBuilder(builder: (context, size){
                                        return SizedBox(
                                          height: size.maxWidth,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: Image.memory(
                                              widget.shopItem.image!,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5,5,5,5),
                                            child: Text(
                                              widget.shopItem.title,
                                              textAlign: TextAlign.start,
                                              style: Styles.headerStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5,0,5,5),
                                            child: Text(
                                              NumberFormat.currency(
                                                locale: 'en_US',
                                                symbol: '\$',
                                                decimalDigits: 2
                                              ).format(widget.shopItem.price),
                                              textAlign: TextAlign.start,
                                              style: Styles.bodyStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5,10,5,10),
                                            child: Text(
                                              widget.shopItem.description,
                                              textAlign: TextAlign.start,
                                              style: Styles.bodyStyle,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(5,5,5,5),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "Categories: ${widget.shopItem.categorieStrings.join(', ')}"
                                                ),
                                              ],
                                            ),
                                          ),
                                          if(widget.shopItem.availableQty>0)
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5,5,5,5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Quantity: "
                                                  ),
                                                  SizedBox(
                                                    child: InputQty(
                                                      maxVal: widget.shopItem.availableQty,
                                                      minVal: 1,
                                                      initVal: 1,
                                                      steps: 1,
                                                      onQtyChanged: (val){
                                                        quantity=val;
                                                      },
                                                      decoration: QtyDecorationProps(
                                                          btnColor: CustomColors.accentPink,
                                                          borderShape: BorderShapeBtn.circle,
                                                          isBordered: false
                                                      ),
                                                      qtyFormProps: QtyFormProps(
                                                        enableTyping: false,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  KSbutton(
                                                    onPressed: () {
                                                      BlocProvider.of<ProductCubit>(context).addItemToCart(widget.shopItem, quantity);
                                                    },
                                                    label: "Add to Cart",
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if(screenSize.maxWidth<=900)
                            Padding(
                              padding: const EdgeInsetsGeometry.fromLTRB(10, 10, 10, 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5,5,5,5),
                                    child: Text(
                                      widget.shopItem.title,
                                      textAlign: TextAlign.start,
                                      style: Styles.headerStyle,
                                    ),
                                  ),
                                  LayoutBuilder(builder: (context, size){
                                    return SizedBox(
                                      height: size.maxWidth,
                                      child: Center(
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
                                    );
                                  }),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5,0,5,5),
                                        child: Text(
                                          NumberFormat.currency(
                                              locale: 'en_US',
                                              symbol: '\$',
                                              decimalDigits: 2
                                          ).format(widget.shopItem.price),
                                          textAlign: TextAlign.start,
                                          style: Styles.bodyStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5,10,5,10),
                                        child: Text(
                                          widget.shopItem.description,
                                          textAlign: TextAlign.start,
                                          style: Styles.bodyStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5,5,5,5),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Categories: ${widget.shopItem.categorieStrings.join(', ')}"
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(widget.shopItem.availableQty>0)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5,5,5,5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text("Quantity: "),
                                              SizedBox(
                                                width: 100,
                                                child: InputQty(
                                                  maxVal: widget.shopItem.availableQty,
                                                  minVal: 1,
                                                  initVal: 1,
                                                  steps: 1,
                                                  onQtyChanged: (val){
                                                    quantity=val;
                                                  },
                                                  decoration: QtyDecorationProps(
                                                      btnColor: CustomColors.accentPink,
                                                      borderShape: BorderShapeBtn.circle,
                                                      isBordered: false
                                                  ),
                                                  qtyFormProps: QtyFormProps(
                                                    enableTyping: false,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: KSbutton(
                                                  onPressed: () {
                                                    BlocProvider.of<ProductCubit>(context).addItemToCart(widget.shopItem, quantity);
                                                  },
                                                  label: "Add to Cart",
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if(ShopItemRepository().listRecent.isNotEmpty)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Recently Viewed:",
                                textAlign: TextAlign.start,
                                style: Styles.headerStyle,
                              ),
                            ),
                          if(ShopItemRepository().listRecent.isNotEmpty)
                            RecentsWidget(),
                          Footer()
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
         ),
        ),
      ),
    );
  }
}