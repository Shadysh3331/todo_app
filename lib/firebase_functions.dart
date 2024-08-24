import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirebaseFunctions{
  static CollectionReference<TaskModel> getTasksCollection(){
    return FirebaseFirestore.instance.collection("Tasks")
        .withConverter(fromFirestore: (snapshot,_){
      return TaskModel.fromJson((snapshot.data()!));
    },
        toFirestore: (taskModel,_){
          return taskModel.toJson();
        });
  }
  static CollectionReference<UserModel> getUserCollection(){
    return FirebaseFirestore.instance.collection("Users")
        .withConverter(fromFirestore: (snapshot,_){
      return UserModel.fromJson((snapshot.data()!));
    },
        toFirestore: (user,_){
          return user.toJson();
        });
  }
  static Future<UserModel?> readUser()async{
    DocumentSnapshot<UserModel> docRef= await getUserCollection().doc(FirebaseAuth.instance.currentUser?.uid).get();
    return docRef.data();
  }
static Future<void> addUser(UserModel usermodel){
    var collection=getUserCollection();
    var docRef=collection.doc(usermodel.id);
   return docRef.set(usermodel);
  }

  static Future<void> addTask(TaskModel model)async{
  var collection=getTasksCollection();
  var docRef=collection.doc();
  model.id=docRef.id;
  docRef.set(model);
    
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime datetime){
    var collection=getTasksCollection();
    return collection
    .where("userId",isEqualTo: FirebaseAuth.instance.currentUser?.uid)
    .where("date",isEqualTo: DateUtils.dateOnly(datetime).microsecondsSinceEpoch).snapshots();
  }
  static Future<void> deleteTask(String id){
    return getTasksCollection().doc(id).delete();
  }
  static Future<void> updateTask(TaskModel model){
    return getTasksCollection().doc(model.id).update(model.toJson());
  }
  static loginUser(String emailAddress,String password,{required Function onSuccess,required Function onError})async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }catch (e) {
      onError(e.toString());
    }
  }
 static createAccountAuth(String emailAddress,String password,
     {required Function onSuccess,
       required Function onError,required String username,required String phone,required int age})async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user?.sendEmailVerification();
      UserModel userModel=UserModel(id: credential.user!.uid,username: username, phone: phone, age: age, email: emailAddress);
      addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
     onError(e.message);
    } catch (e) {
     onError(e.toString());
    }
  }
}