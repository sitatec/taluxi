import 'package:meta/meta.dart';

class TaluxiError {
  final ErrorType errorType;
  final String message;
  const TaluxiError({@required this.errorType, @required this.message});
}

enum ErrorType { unknownEmail }
