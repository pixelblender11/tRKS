import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trks/Features/Features.dart';
import 'package:trks/Repositories/Repositories.dart';

import 'Models/Models.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ValidationScreen(title: "");
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        String? searchText = state.uri.queryParameters['searchText'];
        if(searchText!=null){
          return MainPage(key: Key(searchText),title: "",searchText: searchText);
        }
        return MainPage(title: "",searchText: searchText);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/product/:id',
          builder: (BuildContext context, GoRouterState state) {
            int key=int.parse(state.pathParameters['id']!);
            ShopItem item=ShopItemRepository().listShopItems.firstWhere((x)=>x.pKey==key);
            return ProductScreen(shopItem: item);
          },
          onExit: (BuildContext context, GoRouterState state) async {
            List<ShopItem> retVal=[];
            retVal.addAll(ShopItemRepository().listCart.toList());
            ShopItemRepository().listCartVN.value=retVal;
            return true;
          }
        ),
      ],
    ),
  ],
);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: router,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.pinkAccent),
      ),
    );
  }
}
