import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trks/Features/Features.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/Utilities/Utilities.dart';

import '../../../Models/Models.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final TextEditingController searchBarController=TextEditingController();
  final ValueNotifier<int> index=ValueNotifier(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    tabController=TabController(length: 2, vsync: this);
    index.addListener(() {
      tabController.index=index.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/kendra-bg1.jpg"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter
        ),
        color: CustomColors.backgroundPink
      ),
      child: LayoutBuilder(
        builder: (context,constraints) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<MainCubit>(
                create: (BuildContext context) => MainCubit()..loadData(),
              ),
              BlocProvider<ShopCubit>(
                create: (BuildContext context) => ShopCubit(),
              ),
            ],
            child: Scaffold(
              key: _scaffoldKey,
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              endDrawer: CartScreen(),
              endDrawerEnableOpenDragGesture: false,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyActions: false,
                title: Center(
                  child: ValueListenableBuilder(
                    valueListenable: index,
                    builder: (context,value,child) {
                      return SizedBox(
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
                                      index.value=0;
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
                            if(index.value==1)
                              Expanded(
                                child: TextFormField(
                                  minLines: 1,
                                  controller: searchBarController,
                                  onFieldSubmitted: (value) {
                                    BlocProvider.of<ShopCubit>(context).onSearchOrFilter(
                                      value,
                                      (BlocProvider.of<ShopCubit>(context).state as ShopInitial).categoryKey,
                                      (BlocProvider.of<ShopCubit>(context).state as ShopInitial).orderBy
                                    );
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
                            if(index.value!=1)
                              Flexible(child: Container()),
                            SizedBox(
                              width: 90,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GlassConversion.defaultAsGlass(
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            child: Icon(
                                              Icons.home_outlined,
                                              color: index.value==0 ? CustomColors.accentPink : null,
                                            ),
                                            onTap: () {
                                              index.value=0;
                                            }
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            child: Icon(
                                              Icons.shopping_bag_outlined,
                                              color: index.value==1 ? CustomColors.accentPink : null,
                                            ),
                                            onTap: () {
                                              index.value=1;
                                            }
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ),
                            ),
                            GlassConversion.defaultAsGlass(
                              ValueListenableBuilder(
                                valueListenable: ShopItemRepository().listCartVN,
                                builder: (context, value, child) {
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
                                                      ShopItemRepository().listCart.length.toString(),
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
                      );
                    })
                ),
              ),
              body: BlocConsumer<MainCubit,MainState>(
                listener: (context, state){},
                builder: (context, state) {
                  if(state is MainInitial){
                    return CircularProgressIndicator();
                  }
                 return Align(
                   alignment: Alignment.topCenter,
                   child: TabBarView(
                     physics: const NeverScrollableScrollPhysics(),
                     controller: tabController,
                     children: [
                       SingleChildScrollView(
                         child: Center(
                           child: Container(
                             padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                             constraints: BoxConstraints(
                              maxWidth: 1600
                             ),
                             child: HomeWidget()
                           ),
                         ),
                       ),
                       SingleChildScrollView(
                         child: Center(
                           child: Container(
                             padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                             constraints: BoxConstraints(
                                 maxWidth: 1200
                             ),
                             child: ShopWidget(
                               searchBarController:searchBarController,
                               cubit: BlocProvider.of<ShopCubit>(context),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 );
                },
              )
          ),
);
        }
      ),
    );
  }
}