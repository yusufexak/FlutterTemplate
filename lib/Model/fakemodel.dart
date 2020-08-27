import 'package:denemehttp/Core/Base/basemodel.dart';

class Fake extends BaseModel {
  int userId;
  int id;
  String title;
  String body;

  Fake({this.userId, this.id, this.title, this.body});

  @override
  Fake fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    return Fake(userId: userId, id: id, body: body, title: title);
  }

  @override
  Map<String, dynamic> toJson() {
    return null;
  }

  @override
  String toString() {
    return title.toString();
  }
}
