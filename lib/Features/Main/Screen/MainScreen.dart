import 'package:flutter/material.dart';
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
    tabController=TabController(length: 4, vsync: this);
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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Center(
                child: ValueListenableBuilder(
                  valueListenable: index,
                  builder: (context,value,child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 75,
                      children: [
                        SizedBox(
                          width: 75,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: Text(
                                "Home",
                                textAlign: TextAlign.right,
                                style: index.value==0 ? TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: CustomColors.accentPink,
                                  color: CustomColors.accentPink
                                ) : null,
                              ),
                              onTap: () {
                                index.value=0;
                                }
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: Text(
                                "Bio",
                                textAlign: TextAlign.right,
                                style: index.value==1 ? TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: CustomColors.accentPink,
                                    color: CustomColors.accentPink
                                ) : null,
                              ),
                              onTap: () {
                                index.value=1;
                              }
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Image.asset(
                              'assets/images/kendra_seunderland_logox2.png',
                              fit: BoxFit.contain,
                              height: AppBar().preferredSize.height,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: Text(
                                "Shop",
                                textAlign: TextAlign.left,
                                style: index.value==2 ? TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: CustomColors.accentPink,
                                  color: CustomColors.accentPink
                                ) : null,
                              ),
                              onTap: () {
                                index.value=2;
                              }
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 75,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              child: Text(
                                "Login",
                                textAlign: TextAlign.left,
                                style: index.value==3 ? TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: CustomColors.accentPink,
                                    color: CustomColors.accentPink
                                ) : null,
                              ),
                              onTap: () {
                                index.value=3;
                              }
                            ),
                          ),
                        ),
                      ],
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
                   child: Container(
                     constraints: BoxConstraints(
                         maxWidth: 800
                     ),
                     margin: EdgeInsets.all(0),
                     child: TabBarView(
                       physics: const NeverScrollableScrollPhysics(),
                       controller: tabController,
                       children: [
                         HomeWidget(),
                         BioWidget(),
                         HomeWidget(),
                         HomeWidget()
                       ],
                     )
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