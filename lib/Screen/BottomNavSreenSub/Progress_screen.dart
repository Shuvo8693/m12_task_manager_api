import 'dart:developer';

import 'package:flutter/material.dart';

import '../../Data/NetWorkCaller/NetworkResponse.dart';
import '../../Data/NetWorkCaller/network_caller.dart';
import '../../Data/Url/Url.dart';
import '../../Data/pojo_model_class/TaskListModal.dart';
import '../../Widget/CardViewItem.dart';
import '../../Widget/Profile_summery.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  bool progressInProgress = false;
  TaskListModal taskListModel =
      TaskListModal(); //only this is for global use variable

  Future<void> progressTaskStatusList() async {
    progressInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.progressTask);
    log(response.statusCode.toString());
    progressInProgress = false;
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
    progressTaskStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ProfileSummary(),
          Expanded(
            child: Visibility(
              visible: progressInProgress==false,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CardViewItem(
                    taskList: taskListModel.task![index],
                    getUpdateScreen: () {
                      progressTaskStatusList();
                    }, taskInProgress: (bool inProgress ) {
                      progressInProgress=inProgress;
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
