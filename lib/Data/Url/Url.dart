import 'package:m12_task_manager_api/Data/pojo_model_class/TaskListModal.dart';
import 'package:m12_task_manager_api/Widget/CardViewItem.dart';

class Urls {
  static const String baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$baseUrl/registration';
  static const String logIn= '$baseUrl/login';
  static const String createTask= '$baseUrl/createTask';
  static const String countTask= '$baseUrl/taskStatusCount';
  static  String newTaskStatus= '$baseUrl/listTaskByStatus/${UpdateTaskEn.New.name}';
  static  String progressTask= '$baseUrl/listTaskByStatus/${UpdateTaskEn.Progress.name}';
  static  String completedTask= '$baseUrl/listTaskByStatus/${UpdateTaskEn.Completed.name}';
  static  String cancelledTask= '$baseUrl/listTaskByStatus/${UpdateTaskEn.Cancelled.name}';
  static  String deleteTask(String sId)=> '$baseUrl/deleteTask/$sId';

  static updateTaskLink(String sID,String enValue)=> '$baseUrl/updateTaskStatus/$sID/$enValue';

}

/*    static:
        static in Dart is used to define class-level members, meaning they belong to the class itself rather than an instance of the class.
        In this case, baseUrl and registration are associated with the class Urls and can be accessed without creating an instance of the Urls class. They are shared among all instances of the class.

    const:
        const in Dart is used to declare compile-time constants. It ensures that the values are known at compile time and can be optimized by the Dart compiler.
        In the context of your code, both baseUrl and registration are constants. This is beneficial for a couple of reasons:
            Immutability: Once the values are set during compilation, they cannot be changed during runtime. This can prevent accidental modifications and improve code reliability.
            Performance: Constants are evaluated at compile time, potentially leading to better performance as the values are known in advance.*/
