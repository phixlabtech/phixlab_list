import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/api/api_client.dart';
import '../model/phixlab_staff_model.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({Key? key}) : super(key: key);

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  PhixlabStaff? staff;
  List<GroupedStaff> gstaff = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await updateState();


    });
  }

  updateState() async {
    final result = await ApiClient.fetchStaff();
    setState(() {
      gstaff = result;
    });

    if (kDebugMode) {
      print('  ==> group ${gstaff.first.role}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Phixlab Staff"),
        ),
        body: gstaff.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Designation",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: gstaff.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            GroupedStaff staff = gstaff[index];

                            return ExpansionTile(
                              title: Text(
                                staff.role,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              children: [
                                ...staff.groupStaff.map((e) => ListTile(
                                      title: Text(
                                        e.name!,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                      ),
                                    ))
                              ],
                            );
                          }))
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ));
  }
}
