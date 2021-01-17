import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:taluxi/services/real_time_location/device_location_handler.dart';
import 'package:user_manager/user_manager.dart';

//TODO handle error (convert all exception message to user friendly)

class RealTimeLocation {
  final UserRepository _userRepository;
  final DeviceLocationHandler _deviceLocationHandler;
  bool _realTimeLocationInitialized = false;
  String city;
  RealTimeLocation({
    @required UserRepository userRepository,
    @required DeviceLocationHandler deviceLocationHandler,
  })  : _userRepository = userRepository,
        _deviceLocationHandler = deviceLocationHandler;

  Future<void> initialize(ReverseGeocoder reverseGeocoder) async {
    final currentCoordinate =
        await _deviceLocationHandler.getCurrentCoordinate();
    city = await reverseGeocoder.getCityFromCoordinates(currentCoordinate);
    _realTimeLocationInitialized = true;
  }

  Stream<Coordinate> startLocationTracking(String idOfUserToTrack) {
    return _userRepository
        .getLocationStream(city: city, userUid: idOfUserToTrack)
        .map(
          (coordinateMap) => Coordinate(
            latitude: coordinateMap['latitude'],
            longitude: coordinateMap['longitude'],
          ),
        );
  }

  void startSharingLocation(
      {@required String currentUserId, double distanceFilter = 50}) {
    _deviceLocationHandler
        .getCoordinatesStream(distanceFilter: distanceFilter)
        .listen((coordinate) {
      _userRepository.updateLocation(
        city: city,
        userUid: currentUserId,
        gpsCoordinates: coordinate.toMap(),
      );
    });
  }
}

class ReverseGeocoder {
  Future<String> getCityFromCoordinates(Coordinate coordinate) async {
    final placeMarks = await placemarkFromCoordinates(
      coordinate.latitude,
      coordinate.longitude,
    );
    return placeMarks.first.locality;
  }
}
