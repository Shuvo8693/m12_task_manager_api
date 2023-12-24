import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:m12_task_manager_api/Data/Controllers/addNewTask_Controller.dart';
import 'package:m12_task_manager_api/Widget/SnackMessage.dart';
import '../Widget/Profile_summery.dart';
import '../Widget/background_picture.dart';
import 'main_bottomNavBar_screen.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEC=TextEditingController();
  final TextEditingController _descriptionTEC=TextEditingController();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
 AddNewTaskController addNewTaskController=Get.find<AddNewTaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              const ProfileSummary(),
              Expanded(
                child: BackgroundBody(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add New Task',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: _titleTEC,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: 'Subject',
                                ),
                                validator: (String? value){
                                  if(value?.trim().isEmpty??true){
                                    return 'Enter Your Subject';
                                  }return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: _descriptionTEC,
                                maxLines: 6,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: 'Description',
                                ),
                                validator: (String? value){
                                  if(value?.trim().isEmpty??true){
                                    return 'Enter Your Description';
                                  }return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: GetBuilder<AddNewTaskController>(
                                    builder: (addNewTaskCont) {
                                      return Visibility(
                                        visible: addNewTaskCont.addTaskInProgress==false,
                                        replacement: const Center(child: CircularProgressIndicator()),
                                        child: ElevatedButton(
                                            onPressed: addNewTask,
                                            child:
                                            const Icon(Icons.arrow_circle_right_outlined)),
                                      );
                                    }
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
  Future<void>addNewTask()async{
    if(!_formKey.currentState!.validate()){ // ! not validate jodi hoy tahole return null hoba, ar validate jodi true hoy then else e return hobe nicher function theke
      return;
    }
    final netResponse=await AddNewTaskController().addNewTask(_titleTEC.text.trim(), _descriptionTEC.text);
   if(netResponse){
     _titleTEC.clear();
    _descriptionTEC.clear();
    Get.to(const BottomNavBar());
   }else{
     if(mounted) {
         snackMessage(context,addNewTaskController.failureMessage);
       }
     }
   }
  @override
  void dispose() {
    _titleTEC.dispose();
    _descriptionTEC.dispose();
    super.dispose();
  }
}
