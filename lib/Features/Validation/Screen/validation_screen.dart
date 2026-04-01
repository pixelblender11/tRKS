import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trks/Utilities/Utilities.dart';
import 'package:trks/Features/Features.dart';
import 'package:trks/Widget/Widgets.dart';
import 'package:web/web.dart' as web;

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/kendra-bg1.jpg"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter
          ),
        ),
        alignment: Alignment.topCenter,
        child: BlocProvider(
          create: (context)=>ValidationCubit(),
          child: BlocConsumer<ValidationCubit,ValidationState>(
            listener: (context, state){},
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.all(10),
                constraints: BoxConstraints(maxWidth: 1500),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GlassConversion.defaultAsGlass(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Flexible(
                                child: Image.asset('assets/images/ks_disclaimer.png'),
                              ),
                              Flexible(
                                  child: Text(
                                    "Welcome to KendraSunderlandVIP.com, the Official Website of Porn Star, Kendra Sunderland, AKA: Library Girl.\nBy entering this site, you acknowledge and agree that you are not offended by nudity and explicit depictions of sexual activity. By entering this site, you also certify under penalty of perjury that you are an adult.",
                                    textAlign: TextAlign.center,
                                  )
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 20,
                                  children: [
                                    KSbutton(
                                      onPressed: () async {
                                        await Initializer.init();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => const MainPage(title: '',)
                                          ),
                                          (Route<dynamic> route) => false, // This predicate ensures all previous routes are removed
                                        );
                                      },
                                      label: "I am over 18",
                                    ),
                                    KSbutton(
                                      alternativeColor: true,
                                      onPressed: () {
                                        web.window.location.replace(
                                            "https://google.com");
                                      },
                                      label: "Leave",
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                      Footer()
                    ],
                  )
                ),
              );
            },
          ),
        ),
      )
    );
  }
}