import 'package:get/get.dart';

class TabStateController extends GetxController {
  int index = 0;

  change({required int newValue}) {
    index = newValue;
    update();
  }
}
