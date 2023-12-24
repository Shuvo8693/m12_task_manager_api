import 'dart:developer';

import 'package:get/get.dart';

import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import '../pojo_model_class/Count_Status.dart';

class CountStatusController extends GetxController{
  bool _countInProgress = false;
  CountStatus _countStatus = CountStatus();
  bool get countInProgress=>_countInProgress;
  CountStatus get countStatus=>_countStatus;

  Future<bool> countTaskStatus() async {
    _countInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.countTask);
    log(response.statusCode.toString());

    _countInProgress = false;
    update();
    if (response.isSuccess) {
      _countStatus = CountStatus.fromJson(response.jsonResponse!);
      print(countStatus.status);
      return true;
    }
    return false;
  }
}