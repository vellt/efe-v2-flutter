import 'package:efe_v2_flutter/screens/book/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SimpleBuilder(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Efe v2 Client',
          home: BookScreen(),
          theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent, // Status bar
                statusBarIconBrightness: Brightness.light,
              ),
            ),
          ),
        );
      });
    });
  }
}
