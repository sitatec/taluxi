import 'package:flutter/foundation.dart';

class DeviceLocationHandlerException implements Exception {
  final String message;
  final DeviceLocationHandlerExceptionType exceptionType;
  const DeviceLocationHandlerException(
      {@required this.message, @required this.exceptionType});

  DeviceLocationHandlerException.permissionDenied()
      : message = 'Location access permission denied',
        exceptionType = DeviceLocationHandlerExceptionType.permissionDenied;

  DeviceLocationHandlerException.permissionPermanentlyDenied()
      : message = 'Location access permission is permanently denied',
        exceptionType =
            DeviceLocationHandlerExceptionType.permissionPermanentlyDenied;

  DeviceLocationHandlerException.insufficientPermission()
      : message =
            'The granted permission is insufficient for the requested service.',
        exceptionType =
            DeviceLocationHandlerExceptionType.insufficientPermission;

  DeviceLocationHandlerException.locationServiceDisabled()
      : message = 'The location service is desabled',
        exceptionType =
            DeviceLocationHandlerExceptionType.locationServiceDisabled;

  DeviceLocationHandlerException.locationServiceUninitialized()
      : message =
            'The location service is not initialized you must initialize it before using it.',
        exceptionType =
            DeviceLocationHandlerExceptionType.locationServiceUninitialized;

  @override
  String toString() => 'DeviceLocationHandlerException :\n' + message;
}

enum DeviceLocationHandlerExceptionType {
  permissionDenied,
  permissionPermanentlyDenied,
  insufficientPermission,
  locationServiceDisabled,
  locationServiceUninitialized
}
