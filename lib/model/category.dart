import 'package:car_app/model/subcategory.dart';

class Category {
  int? Id;
  String? Name;
  String? ImageUrl;
  List<SubCategory>? SubCategories;

  Category({this.Id, this.Name, this.ImageUrl, this.SubCategories});

  Category.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Name = json['Name'];
    ImageUrl = json['imageUrl'];
    SubCategories = List<SubCategory>.from(json["SubCategories"].map((x) => SubCategory.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.Id;
    data['Name'] = this.Name;
    data['ImageUrl'] = this.ImageUrl;
    data['SubCategories'] = this.SubCategories;
    return data;
  }
}
