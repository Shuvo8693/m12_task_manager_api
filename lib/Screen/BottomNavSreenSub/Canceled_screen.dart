import 'dart:developer';

import 'package:flutter/material.dart';

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
  bool cancelledInProgress = false;
  TaskListModal taskListModel =
      TaskListModal(); //only this is for global use variable

  Future<void> cancelledTaskStatusList() async {
    cancelledInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelledTask);
    log(response.statusCode.toString());
    cancelledInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      taskListModel = TaskListModal.fromJson(response.jsonResponse!);
    }
  }

  @override
  void initState() {
    super.initState();
    cancelledTaskStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ProfileSummary(),
          Expanded(
            child: Visibility(
              visible: cancelledInProgress==false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CardViewItem(
                    taskList: taskListModel.task![index],
                    getUpdateScreen: () {
                      cancelledTaskStatusList();
                    },
                    taskInProgress: (bool inProgress) {
                      cancelledInProgress=inProgress;
                      if(mounted){
                        setState(() {});
                      }
                    }, updateCountScreen: () {null;  },
                  );
                },
                itemCount: taskListModel.task?.length??0,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
