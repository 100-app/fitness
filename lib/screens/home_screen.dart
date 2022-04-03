// ignore_for_file: unnecessary_new, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/model/task_model.dart';
import 'package:fitness/model/user_model.dart';
import 'package:fitness/screens/tasks/create_task.dart';
import 'package:fitness/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  TaskModel userTasks = TaskModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(115, 49, 49, 49),
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          subtitle1: TextStyle(),
        ).apply(
          bodyColor: Colors.lightBlue,
          //displayColor: Colors.red,
        ),
      ),
    );
    // ignore: prefer_typing_uninitialized_variables
    var _formKey;
    final List<String> taskData = [];
    FirebaseFirestore.instance.collection("tasks").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (result.data()["uid"] == loggedInUser.uid) {
          taskData.add(result.data()["taskID"]);
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(15, 49, 49, 49),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text("${loggedInUser.firstname}"),
                  RoundedButton(
                    onPressed: () {},
                    child: const Text("Tasks"),
                    color: Colors.indigoAccent,
                    bordeRadius: 30.0,
                    width: 500.0,
                    height: 50.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateTask()));
        },
        tooltip: 'Create Task',
        child: const Icon(Icons.create),
      ),
    );
  }
}
