import 'package:google_maps_routes/google_maps_routes.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsRoutesSample extends StatefulWidget {
  MapsRoutesSample({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MapsRoutesSampleState createState() => _MapsRoutesSampleState();
}

class _MapsRoutesSampleState extends State<MapsRoutesSample> {
  Completer<GoogleMapController> _controller = Completer();

  List<LatLng> points = [
    LatLng(13.778597300117617, 100.56008663339044),
    LatLng(13.778451582205765, 100.56026372432859),
    LatLng(13.778083703794486, 100.56079991633581),
    LatLng(13.775740256899034, 100.55949878979669)
  ];

  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'YOUR KEY HERE';
  String totalDistance = 'No route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: GoogleMap(
              zoomControlsEnabled: false,
              polylines: route.routes, // add polylines here
              initialCameraPosition: const CameraPosition(
                zoom: 15.0,
                target: LatLng(13.778597300117617, 100.56008663339044),
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Align(
                    alignment: Alignment.center,
                    child:
                        Text(totalDistance, style: TextStyle(fontSize: 25.0)),
                  )),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await route.drawRoute(points, 'Test routes',
              Color.fromARGB(255, 219, 22, 133), googleApiKey,
              travelMode: TravelModes.walking);
          setState(() {
            totalDistance =
                distanceCalculator.calculateRouteDistance(points, decimals: 1);
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
