import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Data/pojo_model_class/TaskListModal.dart';
import 'package:m12_task_manager_api/Screen/login_screen.dart';
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
  bool taskInProgress = false;
  bool countInProgress = false;
  TaskListModal taskListModel =
      TaskListModal(); //only this is for global use variable
  CountStatus countStatus = CountStatus();

  Future<void> newTaskStatusList() async {
    taskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newTaskStatus);
    log(response.statusCode.toString());
    taskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      taskListModel = TaskListModal.fromJson(response.jsonResponse!);
    }else if(response.statusCode==401){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
  }

  Future<void> countTaskStatus() async {
    countInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.countTask);
    log(response.statusCode.toString());

    if (response.isSuccess) {
      countStatus = CountStatus.fromJson(response.jsonResponse!);
      print(countStatus.status);
    }
    countInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    newTaskStatusList();
    countTaskStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary(),
            Visibility(
              visible: countInProgress == false &&
                  (countStatus.countVariable?.isNotEmpty ?? false),
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 110,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final status = countStatus.countVariable?[index];
                    return CardSummary(
                      count: status!.sum.toString(),
                      title: status.sId ?? '',
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: countStatus.countVariable?.length,
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: !taskInProgress,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CardViewItem(
                      taskList: taskListModel.task![index],
                      getUpdateScreen: newTaskStatusList,
                      taskInProgress: (bool inProgress) {
                        taskInProgress = inProgress;
                        if(mounted){
                          setState(() {});
                        }
                      }, updateCountScreen: countTaskStatus,
                    );
                  },
                  itemCount: taskListModel.task?.length ?? 0,
                ),
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
