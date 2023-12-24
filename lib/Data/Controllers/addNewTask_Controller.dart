import 'package:get/get.dart';

import '../NetWorkCaller/NetworkResponse.dart';
import '../NetWorkCaller/network_caller.dart';
import '../Url/Url.dart';
import 'newTaskStatus_Controller.dart';

class AddNewTaskController extends GetxController{
 bool _addTaskInProgress=false;
 String _failureMessage='';
 bool get addTaskInProgress=>_addTaskInProgress;
 String get failureMessage=>_failureMessage;

  Future<bool>addNewTask(String title,String description)async{
    bool isSuccess=false;
    _addTaskInProgress=true;
   update();
    NetworkResponse netResponse= await NetworkCaller().postRequest(Urls.createTask, body: {
      "title":title,
      "description":description,
      "status":"New"
    });
    _addTaskInProgress=false;
    update();
    if(netResponse.isSuccess){
      Get.find<NewTaskStatusController>().newTaskStatusList();
      return isSuccess=true;
    }else{
      if (netResponse.statusCode == 401) {
          _failureMessage= 'Add New Task has Failed ! Please Try Again';
        } else {
          _failureMessage= 'Unconditional Error';
        }
    }
    return false;
  }
}