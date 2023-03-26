import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class getLocation extends StatefulWidget {
  const getLocation({super.key});

  @override
  State<getLocation> createState() => _getLocationState();
}

class _getLocationState extends State<getLocation> {
  Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  // method to send current location to MySQL server
  Future<void> sendLocationToServer(double latitude, double longitude) async {
    try {
      final response = await http.post(
        Uri.parse('http://your-api-endpoint.com/location'),
        body: {
          'pick_lat': latitude.toString(),
          'pick_lng': longitude.toString(),
        },
      );
      if (response.statusCode == 200) {
        print('Location sent to server successfully');
      } else {
        print('Error sending location to server');
      }
    } catch (e) {
      print('Error sending location to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F9D58),
        // on below line we have given title of app
        title: Text("GFG"),
      ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line we are setting markers on the map
            markers: Set<Marker>.of(_markers),
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());

            // Add a marker for current user's location
            _markers.add(Marker(
              markerId: MarkerId("2"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(
                title: 'My Current Location',
              ),
            ));

            // Specify current user's location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            // Send the location to the database
            final url = Uri.parse('https://your-api-url.com/save-location');
            final response = await http.post(
              url,
              body: {
                'pick_lat': value.latitude.toString(),
                'pick_lng': value.longitude.toString(),
              },
            );

            // Check the response status code
            if (response.statusCode == 200) {
              // If successful, animate the camera to the new location
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            } else {
              // If unsuccessful, show an error message
              print(
                  'Failed to send location to server. Error code: ${response.statusCode}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to send location to server.'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          });
        },
        child: Icon(Icons.local_activity),
      ),
      
    );
  }
}
