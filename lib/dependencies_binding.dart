import 'package:get/get.dart';
import 'package:m12_task_manager_api/Data/Auth_Controller/auth_controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/addNewTask_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/canceled_controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/countStatus_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/logIn_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/mailVerify_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/newTaskStatus_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/pinVerify_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/progress_controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/setPassWord_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/signUp_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/userProfileController.dart';

import 'Data/Controllers/completed_controller.dart';

class DependenciesBindings extends Bindings{
  @override
  void dependencies() {
 Get.put(LoginController());
 Get.put(NewTaskStatusController());
 Get.put(ProgressController());
 Get.put(CompletedController());
 Get.put(CanceledController());
 Get.put(AddNewTaskController());
 Get.put(SignUpController());
 Get.put(MailVerifyController());
 Get.put(PinVerifyController());
 Get.put(SetPassWordController());
 Get.put(AuthController());
 Get.put(UserProfileController());
 Get.put(CountStatusController()); ///
  }

}