import 'package:flutter/cupertino.dart';

class RealTimeLocationException implements Exception {
  String message;
  RealTimeLocationExceptionType exceptionType;
  RealTimeLocationException(
      {@required this.message, @required this.exceptionType});

  RealTimeLocationException.realTimeLocationUninitialized()
      : message =
            'Real time location service is not initialized before using it',
        exceptionType =
            RealTimeLocationExceptionType.realTimeLocationUninitialized;

  @override
  String toString() => 'RealTimeLocationException :\n' + message;
}

enum RealTimeLocationExceptionType {
  locationPermissionDenied,
  realTimeLocationUninitialized
}
