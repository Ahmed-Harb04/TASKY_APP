import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/app_dialog.dart';
import 'package:flutter_application_1/data/firebase/firebase_database.dart';
import 'package:flutter_application_1/data/model/task_model.dart';
import 'package:flutter_application_1/screens/home/widget/home_screen.dart';

class UpdateTaskScreen extends StatelessWidget {
  

  const UpdateTaskScreen({super.key, required this.taskModel});
  static String routeName ='UpdateTaskScreen';
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.deepPurple),
            onPressed: () {
              FirebaseUserDatabase.updateTask(taskModel);
            }, // تعديل عنوان المهمة
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.radio_button_unchecked, color: Colors.deepPurple),
                const SizedBox(width: 10),
                Text(
                  taskModel.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 5),
             Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                taskModel.description,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            // Task Time
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.deepPurple),
                const SizedBox(width: 10),
                const Text("Task Time :"),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                  child: Text("${taskModel.date}", style: const TextStyle(color: Colors.black)),
                )
              ],
            ),
            const SizedBox(height: 15),

            // Task Priority
            Row(
              children: [
                const Icon(Icons.flag, color: Colors.deepPurple),
                const SizedBox(width: 10),
                const Text("Task Priority :"),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                  ),
                  child:  Text(taskModel.priority.toString(), style: TextStyle(color: Colors.black)),
                )
              ],
            ),
            const SizedBox(height: 25),

            // Delete Task
            GestureDetector(
              onTap: () {
                AppDialog.showDialogLoading(context);
                FirebaseUserDatabase.deleteTask(taskModel).then((_){});
                Navigator.pop(context);
                 Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              },
              child: Row(
                children: const [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    "Delete Task",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Edit Task Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Edit Task",style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
