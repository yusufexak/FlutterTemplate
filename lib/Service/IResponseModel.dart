abstract class IResponseModel<T> {
  T data;
  List<T> list;
  String msg = "yusuf";
}

class ResponseModel<T> extends IResponseModel<T> {
  T data;
  List<T> list;
  String msg = "sirin";

  ResponseModel({this.data});
}
