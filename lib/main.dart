import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'model/phixlab_staff_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StaffListScreen(),
    );
  }
}

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({Key? key}) : super(key: key);

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  PhixlabStaff? staff;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      staff ??= await fetchStaff();
      print(staff?.staff?.first.name);
    });
  }

  Future<PhixlabStaff> fetchStaff() async {
    String data = await rootBundle.loadString('assets/json/phixlab_staff.json');
    final jsonResult = await compute(json.decode, data);
    return PhixlabStaff.fromJson(jsonResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Phixlab Staff"),
        ),
        body: Container());
  }
}
