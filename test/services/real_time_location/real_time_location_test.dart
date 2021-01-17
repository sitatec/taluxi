import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taluxi/services/real_time_location/device_location_handler.dart';
import 'package:taluxi/services/real_time_location/real_time_location.dart';
import 'package:user_manager/user_manager.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockDeviceLocationHandler extends Mock implements DeviceLocationHandler {}

class MockReverseGeocoder extends Mock implements ReverseGeocoder {}

void main() {
  RealTimeLocation realTimeLocation;
  UserRepository userRepository;
  DeviceLocationHandler deviceLocationHandler;
  final reverseGeocoder = MockReverseGeocoder();
  const fakeUserId = 'id';
  const fakeCity = 'ccity';
  final fakeUserLocation =
      Coordinate(latitude: 14.356464, longitude: -12.376404);

  setUp(() async {
    userRepository = MockUserRepository();
    deviceLocationHandler = MockDeviceLocationHandler();
    realTimeLocation = RealTimeLocation(
        userRepository: userRepository,
        deviceLocationHandler: deviceLocationHandler);
    when(reverseGeocoder.getCityFromCoordinates(fakeUserLocation))
        .thenAnswer((_) => Future.value(fakeCity));
    when(deviceLocationHandler.getCurrentCoordinate())
        .thenAnswer((_) => Future.value(fakeUserLocation));
    await realTimeLocation.initialize(reverseGeocoder);
  });

  test('Should initialize RealTimeLocation', () async {
    await realTimeLocation.initialize(reverseGeocoder);
    verifyInOrder([
      deviceLocationHandler.getCurrentCoordinate(),
      reverseGeocoder.getCityFromCoordinates(fakeUserLocation)
    ]);
  });

  test('Should tack the location of the user which id given as parameter',
      () async {
    when(userRepository.getLocationStream(city: fakeCity, userUid: fakeUserId))
        .thenAnswer((_) => Stream.value(fakeUserLocation.toMap()));
    expect(
      await realTimeLocation.startLocationTracking(fakeUserId).first,
      equals(fakeUserLocation),
    );
  });

  test('Should share current user location', () async {
    when(deviceLocationHandler.getCoordinatesStream(distanceFilter: 100))
        .thenAnswer((_) => Stream.value(fakeUserLocation));
    realTimeLocation.startSharingLocation(
        currentUserId: fakeUserId, distanceFilter: 100);
    await Future.delayed(Duration.zero);
    verifyInOrder([
      deviceLocationHandler.getCoordinatesStream(distanceFilter: 100),
      userRepository.updateLocation(
        city: fakeCity,
        userUid: fakeUserId,
        gpsCoordinates: fakeUserLocation.toMap(),
      )
    ]);
  });
}
