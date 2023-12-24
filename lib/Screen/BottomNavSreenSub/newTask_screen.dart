import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m12_task_manager_api/Data/Controllers/countStatus_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/newTaskStatus_Controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Data/pojo_model_class/TaskListModal.dart';
import 'package:m12_task_manager_api/Screen/login_screen.dart';
import 'package:m12_task_manager_api/main.dart';
import '../../Data/pojo_model_class/Count_Status.dart';
import '../../Widget/CardViewItem.dart';
import '../../Widget/Profile_summery.dart';
import '../../Widget/card_summary.dart';
import '../AddNewTask_Screen.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  NewTaskStatusController newTaskStatusController=Get.find<NewTaskStatusController>();
  final CountStatusController _countStatusController =Get.find<CountStatusController>();

  @override
  void initState() {
    super.initState();
   newTaskStatusController.newTaskStatusList();
    _countStatusController.countTaskStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary(),
            GetBuilder<CountStatusController>(
              builder: (countStatusController) {
                return Visibility(
                  visible: countStatusController.countInProgress == false &&
                      (countStatusController.countStatus.countVariable?.isNotEmpty ?? false),
                  replacement: const LinearProgressIndicator(),
                  child: SizedBox(
                    height: 110,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final status = countStatusController.countStatus.countVariable?[index];
                        return CardSummary(
                          count: status!.sum.toString(),
                          title: status.sId ?? '',
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: countStatusController.countStatus.countVariable?.length,
                    ),
                  ),
                );
              }
            ),
            Expanded(
              child: GetBuilder<NewTaskStatusController>(
                builder: (taskStatusController) {
                  return Visibility(
                    visible: taskStatusController.taskInProgress==false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CardViewItem(
                          updateCountScreen: _countStatusController.countTaskStatus,
                          taskList: taskStatusController.taskListModel.task![index],
                          getUpdateScreen: () {
                            newTaskStatusController.newTaskStatusList();
                          },
                        );
                      },
                      itemCount: newTaskStatusController.taskListModel.task?.length ?? 0,
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
