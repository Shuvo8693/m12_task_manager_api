import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m12_task_manager_api/Data/Controllers/completed_controller.dart';
import '../../Widget/CardViewItem.dart';
import '../../Widget/Profile_summery.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
 CompletedController completedController=Get.find<CompletedController>();

  @override
  void initState() {
    super.initState();
    completedController.completedTaskStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ProfileSummary(),
          Expanded(
            child: GetBuilder<CompletedController>(
              builder: (completedContr) {
                return Visibility(
                  visible: !completedContr.completedInProgress,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CardViewItem(
                        taskList: completedContr.taskListModel.task![index],
                        getUpdateScreen: () {
                          completedContr.completedTaskStatusList();
                        },
                       /* taskInProgress: (bool inProgress) {
                          completedInProgress= inProgress;
                          if(mounted){
                            setState(() {});
                          }
                        },*/ updateCountScreen: () {null;  },
                      );
                    },
                    itemCount: completedContr.taskListModel.task?.length??0,
                  ),
                );
              }
            ),
          ),
        ],
      )),
    );
  }
}
