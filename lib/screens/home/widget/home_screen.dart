import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/assets_constant.dart';
import 'package:flutter_application_1/core/utils/app_dialog.dart';
import 'package:flutter_application_1/data/firebase/firebase_database.dart';
import 'package:flutter_application_1/data/model/task_model.dart';
import 'package:flutter_application_1/screens/home/widget/alert_dialog_widget.dart';
import 'package:flutter_application_1/screens/home/widget/container_priority_widget.dart';
import 'package:flutter_application_1/screens/home/widget/empty_screen.dart';
import 'package:flutter_application_1/screens/home/widget/show_bottom_sheet_widget.dart';
import 'package:flutter_application_1/screens/home/widget/updata_task_screen.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart'; // تأكد من الاستيراد ده

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleTask = TextEditingController();
  var descriptionTask = TextEditingController();
  int priority = 0;
  DateTime selectedDate = DateTime.now();
  List<TaskModel> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AssetsConstant.logo),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    child: Image.asset(AssetsConstant.logout),
                  ),
                ],
              ),
              SizedBox(height: 43),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Today'),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : tasks.isEmpty
                        ? EmptyScreen()
                        : ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UpdateTaskScreen(
                                      taskModel: tasks[index],
                                    ),
                                  ),
                                );
                              },
                              child: TaskItemWidget(taskModel: tasks[index]),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xff24252C),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ShowBottomSheetWidget(
              titleTask: titleTask,
              descriptionTask: descriptionTask,
              onTapFlag: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialogwidget(
                    onTap: (index) {
                      priority = index;
                    },
                  ),
                );
              },
              onTapSend: () async {
                AppDialog.showDialogLoading(context);

                await FirebaseUserDatabase.addTask(
                  title: titleTask.text,
                  description: descriptionTask.text,
                  priority: priority,
                  date: selectedDate,
                ).then((_) async {
                  Navigator.of(context).pop(); // loading dialog
                  titleTask.clear();
                  descriptionTask.clear();
                  priority = 0;
                  selectedDate = DateTime.now();
                  Navigator.of(context).pop(); // bottom sheet

                  await getTasks(); // reload tasks
                }).catchError((error) {
                  Navigator.of(context).pop();
                  AppDialog.showDialogError(context, error);
                });
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Color(0xff5F33E1),
          size: 30,
        ),
      ),
    );
  }

  Future<void> getTasks() async {
    setState(() {
      isLoading = true;
    });

    tasks = await FirebaseUserDatabase.getAllTasks();

    setState(() {
      isLoading = false;
    });
  }
}

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Radio(value: true, groupValue: '', onChanged: (check) {}),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskModel.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff24252C),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Today ${taskModel.date.day}/${taskModel.date.month}/${taskModel.date.year}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffAFAFAF),
                ),
              ),
            ],
          ),
          const Spacer(),
          ContainerPriorityWidget(
            index: taskModel.priority,
            isSelected: false,
          ),
        ],
      ),
    );
  }
}
