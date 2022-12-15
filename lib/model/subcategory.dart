class SubCategory {
  int? id;
  String? name;
  String? imageUrl;
  String? docType;

  SubCategory(this.id, this.name, this.imageUrl, this.docType,);

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    imageUrl = json['imageUrl'];
    docType = json['docType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.id;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['docType'] = this.docType;
    return data;
  }

}
