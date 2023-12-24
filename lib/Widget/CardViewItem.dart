import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:m12_task_manager_api/Data/Controllers/newTaskStatus_Controller.dart';
import 'package:m12_task_manager_api/Data/Controllers/progress_controller.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Data/pojo_model_class/TaskListModal.dart';

import '../Data/Controllers/completed_controller.dart';

enum UpdateTaskEn { New, Progress, Completed, Cancelled }  // ei parameter e link generate hoice

class CardViewItem extends StatefulWidget {
  const CardViewItem({
    super.key,
    required this.updateCountScreen, required this.taskList, required this.getUpdateScreen,
  });

  final TaskList taskList;
  final VoidCallback getUpdateScreen,updateCountScreen;

  @override
  State<CardViewItem> createState() => _CardViewItemState();
}

///update urls e 2 ta value required kore, sId & enum value provide
/// korar por seta te enum value dhore link generate hoy then,
/// sei link get kore ek ek screen e nea asha hoy,
/// sei data "ListTaskByStatus" api link e thake sekhan theke fetch/get kore ana hoy

class _CardViewItemState extends State<CardViewItem> {
  NewTaskStatusController newTaskStatusController=Get.find<NewTaskStatusController>();
 ProgressController progressController =Get.find<ProgressController>();

  Future<void> updateTaskRequest(String enValue) async {
    final response = await NetworkCaller().getRequest(Urls.updateTaskLink(widget.taskList.sId ?? '', enValue)); // e.name  e value set kora ache niche
    // ei parameter name e link generate hoy, sety get kora hoy other class/screen er jonno & Current Screen e seta thake na ,oy link e data save thake
    if (response.isSuccess) {
      widget.getUpdateScreen(); //recall the function for update after moving data on-screen to Another Screen
      widget.updateCountScreen();
    }
  }

  Future<void> deleteTask() async {
    final responseDe = await NetworkCaller()
        .getRequest(Urls.deleteTask(widget.taskList.sId ?? ''));
    if (responseDe.isSuccess) {
      widget.getUpdateScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    widget.taskList.title ?? '',
                    style: const TextStyle(fontSize: 17),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.taskList.description ?? ''),
                      Text(widget.taskList.createdDate ?? ''),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text(widget.taskList.status ?? 'New'),
                            backgroundColor: Colors.blueAccent,
                          ),
                          Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    updateTaskStatus(context);
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    deleteTask();
                                    widget.updateCountScreen();
                                    widget.getUpdateScreen();
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void updateTaskStatus(BuildContext context){
    List<ListTile> lisTileItem = UpdateTaskEn.values.map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskRequest(e.name); // enValue ta ekhane dea hoice
                widget.updateCountScreen(); // update with tab
                widget.getUpdateScreen();
                progressController.progressTaskStatusList();
                Get.find<CompletedController>().completedTaskStatusList();
                Navigator.pop(context);
              }),
        ).toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: lisTileItem,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blueGrey),
                  ))
            ],
          );
        });
  }
}
