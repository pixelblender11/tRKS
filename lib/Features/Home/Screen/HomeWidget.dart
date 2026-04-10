import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:trks/Features/Features.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/Utilities/Utilities.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Widget/Widgets.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final ExpandableCarouselController _controller=ExpandableCarouselController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return BlocProvider(
      create: (context)=>HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeInitial>(
        listener: (context, state){},
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                //"Welcome to the Official World of Kendra Sunderland",
                "Lerem Ipsum here is some text about the length",
                textAlign: TextAlign.center,
                style: Styles.titleStyle,
              ),
              getCarousel(context, state),
              getSpotlights(context, state),
              Footer(),
            ],
          );
        },
      ),
    );
  }

  Widget getCarousel(BuildContext context,HomeInitial state){
    return LayoutBuilder(
      builder: (context,size) {
        if(size.maxWidth>1005){
          return SizedBox(
            width: 1005,
            child: Row(
              children: [
                if(state.listFeaturettes.length > 3)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 40,
                      height: 50,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back), onPressed: () { _controller.previousPage(); },
                      ),
                    ),
                  ),
                Flexible(
                  child: ExpandableCarousel(
                      items: state.listFeaturettes.where((x)=>x.image!=null).map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                                padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 25),
                                child: FeaturetteWidget(featured: i)
                            );
                          },
                        );
                      }).toList(),
                      options: ExpandableCarouselOptions(
                          controller: _controller,
                          aspectRatio: 4/5,
                          viewportFraction: 1/3,
                          showIndicator: true,
                          indicatorMargin: 10,
                          slideIndicator: CircularWaveSlideIndicator(
                              slideIndicatorOptions: SlideIndicatorOptions(
                                  indicatorBackgroundColor: Colors.pink
                              )
                          ),
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          enlargeCenterPage: true
                      )
                  ),
                ),
                if(state.listFeaturettes.length > 3)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 40,
                      height: 50,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward), onPressed: () { _controller.nextPage(); },
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
        return SizedBox(
          child: Row(
            children: [
              if(state.listFeaturettes.length > 3)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 40,
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back), onPressed: () { _controller.previousPage(); },
                    ),
                  ),
                ),
              Flexible(
                child: ExpandableCarousel(
                    items: state.listFeaturettes.where((x)=>x.image!=null).map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                              padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 25),
                              child: FeaturetteWidget(featured: i)
                          );
                        },
                      );
                    }).toList(),
                    options: ExpandableCarouselOptions(
                        controller: _controller,
                        aspectRatio: 4/5,
                        viewportFraction: 1/1,
                        showIndicator: true,
                        indicatorMargin: 10,
                        slideIndicator: CircularWaveSlideIndicator(
                            slideIndicatorOptions: SlideIndicatorOptions(
                                indicatorBackgroundColor: Colors.pink
                            )
                        ),
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true
                    )
                ),
              ),
              if(state.listFeaturettes.length > 3)
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 40,
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward), onPressed: () { _controller.nextPage(); },
                    ),
                  ),
                ),
            ],
          ),
        );
      }
    );
  }

  Widget getSpotlights(BuildContext context,HomeInitial state) {
    List<Widget> listSpotlights=[];
    for(Spotlight spotlight in SpotlightRepository().listSpotlights){
      listSpotlights.add(
        GlassConversion.defaultAsGlass(
          SpotlightWidget(spotlight: spotlight)
        )
      );
    }
    return LayoutBuilder(builder: (context, size){
      if(size.maxWidth<=900){
        return Padding(
          padding: const EdgeInsets.fromLTRB(40,5,40,5),
          child: Column(
            spacing: 25,
            children: listSpotlights,
          ),
        );
      }
      return Column(
        spacing: 25,
        children: listSpotlights,
      );
    });
  }
}