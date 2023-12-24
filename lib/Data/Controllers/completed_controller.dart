import 'dart:developer';
import 'package:get/get.dart';
import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import '../pojo_model_class/TaskListModal.dart';

class CompletedController extends GetxController{
  bool _completedInProgress = false;
  TaskListModal _taskListModel = TaskListModal();
   bool get completedInProgress=>_completedInProgress;
   TaskListModal get taskListModel=>_taskListModel;

  Future<void> completedTaskStatusList() async {
    /*_completedInProgress = true;
    update();*/
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.completedTask);
    log(response.statusCode.toString());
   /* _completedInProgress = false;
    update();*/
    if (response.isSuccess) {
      _taskListModel = TaskListModal.fromJson(response.jsonResponse!);
      update();
    }
  }
}