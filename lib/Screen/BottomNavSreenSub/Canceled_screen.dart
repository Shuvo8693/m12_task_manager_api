import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m12_task_manager_api/Data/Controllers/canceled_controller.dart';

import '../../Data/NetWorkCaller/NetworkResponse.dart';
import '../../Data/NetWorkCaller/network_caller.dart';
import '../../Data/Url/Url.dart';
import '../../Data/pojo_model_class/TaskListModal.dart';
import '../../Widget/CardViewItem.dart';
import '../../Widget/Profile_summery.dart';

class Canceled extends StatefulWidget {
  const Canceled({super.key});

  @override
  State<Canceled> createState() => _CanceledState();
}

class _CanceledState extends State<Canceled> {
CanceledController canceledController=Get.find<CanceledController>();

  @override
  void initState() {
    super.initState();
    canceledController.cancelledTaskStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ProfileSummary(),
          Expanded(
            child: GetBuilder<CanceledController>(
              builder: (canceledContr) {
                return Visibility(
                  visible: canceledContr.cancelledInProgress==false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CardViewItem(
                        taskList: canceledContr.taskListModel.task![index],
                        getUpdateScreen: () {
                          canceledContr.cancelledTaskStatusList();
                        },
                       /* taskInProgress: (bool inProgress) {
                          cancelledInProgress=inProgress;
                          if(mounted){
                            setState(() {});
                          }
                        },*/ updateCountScreen: () {null;  },
                      );
                    },
                    itemCount: canceledContr.taskListModel.task?.length??0,
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
