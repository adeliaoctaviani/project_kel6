import 'package:get/get.dart';
import 'package:project_kel_6/model/perlombaan.dart';

class CPerlombaan extends GetxController {
  Rx<Perlombaan> _perlombaan = Perlombaan().obs;

  Perlombaan get user => _perlombaan.value;

  void setUser(Perlombaan dataPerlombaan) => _perlombaan.value = dataPerlombaan;
}