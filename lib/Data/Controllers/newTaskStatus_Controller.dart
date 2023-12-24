import 'dart:developer';
import 'package:get/get.dart';
import '../../Screen/login_screen.dart';
import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import '../pojo_model_class/TaskListModal.dart';

class NewTaskStatusController extends GetxController{
  bool _taskInProgress = false;
  TaskListModal _taskListModel = TaskListModal(); //only this is for global use variable
  bool get taskInProgress=>_taskInProgress;
  TaskListModal get taskListModel=>_taskListModel;

  Future<bool> newTaskStatusList() async {
    bool isSuccess=false;
    _taskInProgress = true;
   update();

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.newTaskStatus); // ekhane data get kori
    log(response.statusCode.toString());

    _taskInProgress = false;
    update();

    if (response.isSuccess) {
      _taskListModel = TaskListModal.fromJson(response.jsonResponse!); // ei pojo class e data decode kore rakha hoy, jeno pojo class theke data Ui te show kora hoy
      update();
      return isSuccess=true;

    }else if(response.statusCode==401){
      Get.to(const LoginScreen());
    }
    return false;
  }
}