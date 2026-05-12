import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trks/Features/Features.dart';
import 'package:trks/Utilities/Utilities.dart';

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
  final ValueNotifier<int> index=ValueNotifier(0);

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
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
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
                            width: 135,
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
                                    SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          child: Icon(
                                            Icons.shopping_cart_outlined,
                                          ),
                                          onTap: () {
                                            //index.value=1;
                                          }
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  })
              ),
            ),
            body: BlocProvider(
              create: (context)=>MainCubit(),
              child: BlocConsumer<MainCubit,MainState>(
                listener: (context, state){},
                builder: (context, state) {
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
                             child: ShopWidget(),
                           ),
                         ),
                       ),
                     ],
                   ),
                 );
                },
              ),
            )
          );
        }
      ),
    );
  }
}