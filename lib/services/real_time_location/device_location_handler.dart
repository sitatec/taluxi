import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

import 'exceptions/device_location_handler_exception.dart';

/// The Device location manager.
///
/// This class provides some methods which will help you to use the device location.
class DeviceLocationHandler {
  Location _location;
  bool _locationServiceInitialized = false;
  DeviceLocationHandler({Location location})
      : _location = location ?? Location();

  // TODO: check if the device os version is android 11+ to decide weither to
  // todo: explan to the user how to always allow location permission or not.

  /// Does all required processes required by the location service.
  ///
  /// Must be called first before using any other method otherwise a exception
  /// will be thrown.
  /// [requireBackground] if this parameter is `true` the background location
  /// service will be enabled else it will be disabled.
  Future<void> initialize({bool requireBackground = false}) async {
    await _requireLocationPermission();
    if (!(await _location.serviceEnabled()) &&
        !(await _location.requestService())) {
      throw DeviceLocationHandlerException.locationServiceDisabled();
    }
    await _location.enableBackgroundMode(enable: requireBackground);
    _locationServiceInitialized = true;
  }

  Future<void> _requireLocationPermission() async {
    final locationPermissionStatus = await _location.hasPermission();
    if (locationPermissionStatus != PermissionStatus.granted) {
      if (locationPermissionStatus == PermissionStatus.deniedForever) {
        throw DeviceLocationHandlerException.permissionPermanentlyDenied();
      }
      await _requestLocationPermission();
    }
  }

  Future<void> _requestLocationPermission() async {
    switch (await _location.requestPermission()) {
      case PermissionStatus.denied:
        throw DeviceLocationHandlerException.permissionDenied();
      case PermissionStatus.deniedForever:
        throw DeviceLocationHandlerException.permissionPermanentlyDenied();
      default:
    }
  }

  Future<Coordinate> getCurrentCoordinate() async {
    if (!_locationServiceInitialized)
      throw DeviceLocationHandlerException.locationServiceUninitialized();
    final locationData = await _location.getLocation();
    return Coordinate(
        latitude: locationData.latitude, longitude: locationData.longitude);
  }

  Stream<Coordinate> getCoordinatesStream({double distanceFilter = 50}) {
    if (!_locationServiceInitialized)
      throw DeviceLocationHandlerException.locationServiceUninitialized();
    _location.changeSettings(distanceFilter: distanceFilter);
    return _location.onLocationChanged.map<Coordinate>(
      (locationData) => Coordinate(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
      ),
    );
  }
}

class Coordinate {
  double latitude;
  double longitude;
  Coordinate({@required this.latitude, @required this.longitude});
  Coordinate.fromMap(Map<String, double> map) {
    latitude = map['latitude'];
    longitude = map['longitude'];
  }
  @override
  bool operator ==(Object other) {
    if (other is Coordinate)
      return other.latitude == latitude && other.longitude == longitude;
    else
      return false;
  }

  @override
  int get hashCode => latitude.hashCode + longitude.hashCode;

  Map<String, double> toMap() => {'latitude': latitude, 'longitude': longitude};
}
