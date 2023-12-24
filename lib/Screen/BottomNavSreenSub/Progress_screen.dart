import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m12_task_manager_api/Data/Controllers/progress_controller.dart';
import '../../Widget/CardViewItem.dart';
import '../../Widget/Profile_summery.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
 ProgressController progressController=Get.find<ProgressController>();

  @override
  void initState() {
    super.initState();
    progressController.progressTaskStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ProfileSummary(),
          Expanded(
            child: GetBuilder<ProgressController>(
              builder: (progressContr) {
                return Visibility(
                  visible: progressContr.progressInProgress==false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CardViewItem(
                        taskList: progressContr.taskListModel.task![index],
                        getUpdateScreen: () {
                          progressContr.progressTaskStatusList();},
                        /*taskInProgress: (bool inProgress ) {
                          progressInProgress=inProgress;
                          if(mounted){
                            setState(() {});
                          }
                      },*/ updateCountScreen: () {null;  },
                      );
                    },
                    itemCount: progressContr.taskListModel.task?.length?? 0,
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
