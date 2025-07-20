import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/model/task_model.dart';
import 'package:flutter_application_1/data/model/user_model.dart';

abstract class FirebaseUserDatabase {
  static CollectionReference<UserModel> collectionUser() {
    return FirebaseFirestore.instance
        .collection("User")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.tojson(),
        );
  }

  static Future<void> createUser(UserModel user) async {
    return collectionUser().doc(user.id).set(user);
  }

  static Future<UserModel?> getUser(String userId) async {
    var data = await collectionUser().doc(userId).get();
    return data.data();
  }

  // ✅ وضحنا نوع الدالة: CollectionReference<TaskModel>
  static CollectionReference<TaskModel> collectionTasks() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    return collectionUser()
        .doc(userId)
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<void> addTask({
    required String title,
    required String description,
    required int priority,
    required DateTime date,
  }) async {
    var docRef = collectionTasks().doc();
    String taskId = docRef.id;

    TaskModel userTask = TaskModel(
      id: taskId,
      title: title,
      description: description,
      priority: priority,
      date: date,
    );

    await docRef.set(userTask);
  }

  // ✅ نفس الدالة زي ما هي لكن مرتبة
  static Future<List<TaskModel>> getAllTasks() async {
    var snapshot = await collectionTasks().get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> updateTask(TaskModel task) async {
    return await collectionTasks().doc(task.id).update(task.toJson());
  }

  static Future<void> deleteTask(TaskModel task) async {
    return await collectionTasks().doc(task.id).delete();
  }
}
