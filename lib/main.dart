import 'package:agriiku/provider/cart_provider.dart';
import 'package:agriiku/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'style/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Agri-iku',
          theme: ThemeData(
            primarySwatch: Swing.smoothgreen,
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: const Splashscreen(),
        );
      }),
    );
  }
}
