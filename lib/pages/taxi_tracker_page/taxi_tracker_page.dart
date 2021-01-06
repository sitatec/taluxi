import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/custom_drawer.dart';
import 'taxi_tracker_page_widgets.dart';

class TaxiTracker extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.30883431609419, -12.319779125789227),
    zoom: 15.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  _TaxiTrackerState createState() => _TaxiTrackerState();
}

class _TaxiTrackerState extends State<TaxiTracker> {
  Completer<GoogleMapController> _mapController = Completer();
  var _mapOpacity = 0.0;
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(
        Duration(milliseconds: 500), () => setState(() => _mapOpacity = 1));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrower(),
      body: Builder(
        builder: (context) => Container(
          child: Stack(children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _mapOpacity,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: TaxiTracker._kGooglePlex,
                onMapCreated: (GoogleMapController controller) async {
                  _mapController.complete(controller);
                },
              ),
            ),
            _backButton(context),
            _menuButton(context),
          ]),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: Color(0xFFFFA715),
        backgroundColor: Color(0xFFF2F3F4),
        //buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(
            Icons.my_location,
            size: 25,
            color: Colors.white,
          ),
          Image.asset("assets/images/taxi-sign.png", width: 25, height: 25)
        ],
      ),
    );
  }

  Positioned _menuButton(BuildContext context) {
    return Positioned(
      right: 10,
      top: 55,
      child: InkWell(
        onTap: () => Scaffold.of(context).openEndDrawer(),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: mainLinearGradient,
              borderRadius: BorderRadius.circular(50)),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Positioned _backButton(BuildContext context) {
    return Positioned(
      left: 10,
      top: 55,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: mainLinearGradient,
              borderRadius: BorderRadius.circular(50)),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(TaxiTracker._kLake));
  }
}
