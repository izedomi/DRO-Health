
import 'package:DRHealth/controllers/data_store.dart';
import 'package:DRHealth/screens/bag_screen.dart';
import 'package:DRHealth/screens/onbaording.dart';
import 'package:DRHealth/screens/product_detail.dart';
import 'package:DRHealth/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(

     MultiProvider(
       providers: [
          ChangeNotifierProvider(create: (_) => BagStore()),
       ],
       child: MyApp(),
     )
   
  );
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => BagStore(),
      builder: (context, child){
          BagStore bs = Provider.of<BagStore>(context);
          return MaterialApp(
            title: 'DRHealth',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              accentColor: Color(0xff9F5DE2),
              primaryColor: Color(0xff7B4397),
              fontFamily: 'ProximaNova'
            ),
            home: OnboardingScreen(),
            routes: {
                '/onboarding': (BuildContext context) => OnboardingScreen(),
                '/bag_screen': (BuildContext context) => BagScreen(bagStore: bs),
                '/products_screen': (BuildContext context) => ProductsScreen(bagStore: bs),
                '/product_detail_screen': (BuildContext context) => ProductDetailScreen(bagStore: bs),
            },
          );
      },
    );
  }
}




