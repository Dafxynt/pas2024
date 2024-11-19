import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_10/controller/favorite_controller.dart';
import 'package:pas_mobile_11pplg1_10/controller/profile_controller.dart';
import 'package:pas_mobile_11pplg1_10/menu/efootball/efootball_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeController>(() => AnimeController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
// ohh jadi fungsinya binding adalah agar dapat menggunakan controller nya berulang kali tanpa harus membuat manual lagi setiap dipanggil
