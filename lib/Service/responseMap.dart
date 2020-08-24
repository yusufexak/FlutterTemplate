import 'package:denemehttp/Service/IResponseModel.dart';

class ResponseMap<T> extends IResponseModel<T> {
  final T map;

  ResponseMap(this.map);
}
