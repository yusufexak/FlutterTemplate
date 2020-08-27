import 'package:denemehttp/Service/Response/Error/IError.dart';

class ErrorMessage extends IError {
  final String errorMessage;

  ErrorMessage({this.errorMessage});
}
