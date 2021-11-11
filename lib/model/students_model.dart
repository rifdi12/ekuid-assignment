class StudentsModel {
  String? name;
  String? id;
  String? lastName;
  int? age;

  StudentsModel({this.name, this.id, this.lastName, this.age});

  StudentsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    lastName = json['lastName'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    return data;
  }
}
