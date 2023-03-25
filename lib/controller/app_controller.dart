import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxList<Position> loginPositions = <Position>[].obs;
}
