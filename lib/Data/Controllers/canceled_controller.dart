import 'dart:developer';

import 'package:get/get.dart';

import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import '../pojo_model_class/TaskListModal.dart';

class CanceledController extends GetxController{
  bool _cancelledInProgress = false;
  TaskListModal _taskListModel = TaskListModal();
  bool get cancelledInProgress=>_cancelledInProgress;
  TaskListModal get taskListModel=>_taskListModel;

  Future<void> cancelledTaskStatusList() async {
   /* _cancelledInProgress = true;
    update();*/

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.cancelledTask);
    log(response.statusCode.toString());

   /* _cancelledInProgress = false;
    update();*/
    if (response.isSuccess) {
      _taskListModel = TaskListModal.fromJson(response.jsonResponse!);
      update();
    }
  }
}