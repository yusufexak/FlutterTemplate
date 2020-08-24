import 'IResponseModel.dart';

class ResponseList<T> extends IResponseModel<T> {
  final List<T> list;

  ResponseList(this.list);
}
