import 'package:bssc_app/model/central_exams.dart';
import 'package:bssc_app/model/class_menus.dart';
import 'package:bssc_app/model/state_exams.dart';
import 'package:bssc_app/repositories/home_repo.dart';
import 'package:bssc_app/widgets/snackbar_messenger.dart';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

class HomeController extends GetxController {
  List<SchoolClass>? getSchoolList;
  StateExam? getStatesList;
  CentralExam? getCentralList;

  final showLoading = false.obs;
  final showLoading2 = false.obs;

  @override
  onInit() {
    super.onInit();
    getMenu();
  }

  void getMenu() {
    showLoading2.value = true;

    final either = HomeRepo().getMenu();
    either.fold(
      (error) {
        dev.log("error getMenu ${error.message}");
        Get.showSnackbar(getxSnackbar(message: error.message, isError: true));
        showLoading2.value = false;
      },
      (response) async {
        dev.log("fetching getMenu");
        getSchoolList = (response['data']['classMenues'] as List<dynamic>)
            .map((courseData) => SchoolClass.fromJson(courseData))
            .toList();
        dev.log(getSchoolList.toString());

        final centralExamData = response['data']['examMenues'][0];
        getCentralList = CentralExam.fromJson(centralExamData);

        dev.log(getCentralList.toString());

        final getStatesListData = response['data']['examMenues'][1];
        getStatesList = StateExam.fromJson(getStatesListData);

        dev.log(getStatesList.toString());

        showLoading2.value = false;

        update();
      },
    );
  }
}
