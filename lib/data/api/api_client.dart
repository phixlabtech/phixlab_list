import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../model/phixlab_staff_model.dart';

class ApiClient {
  static Future<List<GroupedStaff>> fetchStaff() async {
    String data = await rootBundle.loadString('assets/json/phixlab_staff.json');
    final jsonResult = await compute(json.decode, data);
    final result = PhixlabStaff.fromJson(jsonResult);
    return _groupListOfStaff(result);
  }

  static List<GroupedStaff> _groupListOfStaff(PhixlabStaff staff) {
    final grouped = staff.staff?.groupListsBy((element) => element.role);
    return grouped!.entries
        .map((rawStaff) =>
            GroupedStaff(role: rawStaff.key!, groupStaff: rawStaff.value))
        .toList();
  }
}
