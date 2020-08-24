import 'IResponseModel.dart';

class ResponseModel<T> extends IResponseModel<T> {
  T data;
  List<T> list;

  ResponseModel();
}
