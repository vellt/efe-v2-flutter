import 'package:efe_v2_flutter/views/book_chooser/book_chooser_new_view.dart';
import 'package:efe_v2_flutter/views/book_chooser_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white, // az állapotsáv színe
      statusBarIconBrightness: Brightness.dark, // az állapotsáv ikonjainak szín
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ),
  );
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
          home: BookChooserView(),
          theme: ThemeData.light(),
        );
      });
    });
  }
}
