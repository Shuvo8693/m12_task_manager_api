import 'dart:developer';
import 'package:get/get.dart';
import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import '../pojo_model_class/TaskListModal.dart';

class ProgressController extends GetxController{

  bool _progressInProgress = false;
  TaskListModal _taskListModel = TaskListModal(); //only this is for global use variable
  TaskListModal get taskListModel=>_taskListModel;
  bool get progressInProgress=>_progressInProgress;

  Future<void> progressTaskStatusList() async {
    _progressInProgress = true;
   update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.progressTask);
    log(response.statusCode.toString());
    _progressInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModal.fromJson(response.jsonResponse!);
      update();
    }
  }
}