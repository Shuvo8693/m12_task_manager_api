import 'package:flutter/material.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/NetworkResponse.dart';
import 'package:m12_task_manager_api/Data/NetWorkCaller/network_caller.dart';
import 'package:m12_task_manager_api/Data/Url/Url.dart';
import 'package:m12_task_manager_api/Screen/BottomNavSreenSub/newTask_screen.dart';
import 'package:m12_task_manager_api/Widget/SnackMessage.dart';
import 'package:m12_task_manager_api/main.dart';
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
 bool addTaskInProgress=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              ProfileSummary(),
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
                                  child: Visibility(
                                    visible: addTaskInProgress==false,
                                    replacement: const Center(child: CircularProgressIndicator()),
                                    child: ElevatedButton(
                                        onPressed: addNewTask,
                                        child:
                                        const Icon(Icons.arrow_circle_right_outlined)),
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
    if(!_formKey.currentState!.validate()){
      return;
    }
    addTaskInProgress=true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse netResponse= await NetworkCaller().postRequest(Urls.createTask, body: {
      "title":_titleTEC.text.trim(),
      "description":_descriptionTEC.text.trim(),
      "status":"New"
    });
    addTaskInProgress=false;
    if(mounted){
      setState(() {});
    }
   if(netResponse.isSuccess){
     _titleTEC.clear();
    _descriptionTEC.clear();
    Navigator.push(TaskManager.navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=>const BottomNavBar()));
   }else{
     if(mounted) {
       if (netResponse.statusCode == 401) {
         snackMessage(context, 'Add New Task has Failed ! Please Try Again');
       } else {
         snackMessage(context, 'Unconditional Error');
       }
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
