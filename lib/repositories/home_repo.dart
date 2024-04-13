import 'package:bssc_app/services/api_services.dart';
import 'package:bssc_app/utils/url.dart';

class HomeRepo {
  EitherResponse getMenu() async => await ApiService.postApi(AppUrl.getMenu);

  EitherResponse getClassSubject(var rawData) async =>
      await ApiService.postApi(rawData, AppUrl.getClassSubject);

  EitherResponse getGroup(var rawData) async =>
      await ApiService.postApi(rawData, AppUrl.getGroup);

  EitherResponse getSubject(var rawData) async =>
      await ApiService.postApi(rawData, AppUrl.getSubject);
}
