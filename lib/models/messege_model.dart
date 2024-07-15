class MessegeModel {
  String email;
  String messege;
  DateTime createdAt;
  MessegeModel(this.email, this.createdAt, this.messege);
  factory MessegeModel.fromJSon(json) {
    return MessegeModel(
        json['id'], json['created at'].toDate(), json['messege']);
  }
}
