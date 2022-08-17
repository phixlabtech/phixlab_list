class PhixlabStaff {
  List<Staff>? staff;

  PhixlabStaff({this.staff});

  PhixlabStaff.fromJson(Map<String, dynamic> json) {
    if (json['phixlab_staff'] != null) {
      staff = <Staff>[];
      json['phixlab_staff'].forEach((v) {
        staff!.add(Staff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (staff != null) {
      data['phixlab_staff'] =
          staff!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Staff {
  String? id;
  String? name;
  String? age;
  String? role;

  Staff({this.id, this.name, this.age, this.role});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['role'] = role;
    return data;
  }
}
