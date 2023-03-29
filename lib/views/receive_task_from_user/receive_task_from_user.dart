import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:user/views/receive_task_from_user/view_selected_item.dart';
import 'from_user_to_nearby_bin.dart';

class receiveTask extends StatefulWidget {
  const receiveTask({super.key});

  @override
  State<receiveTask> createState() => _receiveTaskState();
}

class _receiveTaskState extends State<receiveTask> {
//Get Current Position
  Position? currentPosition;
  GoogleMapController? mapController;
  final Map<String, Marker> _markers2 = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _updateCurrentPosition() async {
    currentPosition = await Geolocator.getCurrentPosition();
    if (currentPosition != null) {
      final marker = Marker(
        markerId: MarkerId('current_location'),
        position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        infoWindow: const InfoWindow(
          title: 'You are here',
        ),
      );
      setState(() {
        _markers2['Current Location'] = marker;
      });
      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        zoom: 15.0,
      )));
    }
  }

//calculate coin
  void calculateCoin(int weight) {
    if (weight >= 1 && weight < 5) {
      var coin = 0.25;
    } else if (weight > 5) {
      var coin = 0.5;
    }
  }

// ShowMap
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

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    var user_lat = 14.079379523123846;
    var user_lng = 100.60415036236294;
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาเส้นทางบนแผนที่ '),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: SafeArea(
                  child: AspectRatio(
                    aspectRatio: 1,
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
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        getUserCurrentLocation().then((value) async {
                          print(value.latitude.toString() +
                              " " +
                              value.longitude.toString());

                          // marker added for current users location
                          _markers.add(Marker(
                            markerId: MarkerId("2"),
                            position: LatLng(value.latitude, value.longitude),
                            infoWindow: InfoWindow(
                              title: ' ${value.latitude} ${value.longitude} ',
                            ),
                          ));

                          // specified current users location
                          CameraPosition cameraPosition = new CameraPosition(
                            target: LatLng(value.latitude, value.longitude),
                            zoom: 14,
                          );

                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition));
                          setState(() {});
                        });
                      },
                      child: Icon(Icons.my_location_rounded),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              // //
              // SizedBox(
              //   width: 360,
              //   height: 500,
              //   child: Card(
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       children: <Widget>[
              //         Text('พิกัดที่คุณอยู่'),
              //         Expanded(
              //           child: GoogleMap(
              //             onMapCreated: _onMapCreated,
              //             markers: _markers.toSet(),
              //             initialCameraPosition: CameraPosition(
              //               target:
              //                   LatLng(13.778597300117617, 100.56008663339044),
              //               zoom: 15.0,
              //             ),
              //           ),
              //         ),
              //         const SizedBox(height: 8),
              //         const Divider(height: 0),
              //         TextButton.icon(
              //           onPressed: _updateCurrentPosition,
              //           icon: const Icon(Icons.my_location),
              //           label: const Text('Get Current Position'),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 360,
                height: 110,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('พิกัดที่ผู้ใช้งานเรียก'),
                      const ListTile(
                        leading: Icon(Icons.share_location),
                        title: Text('อุทยานวิทยาศาสตร์ประเทศไทย'),
                        subtitle: Text(
                          '14.079262043026732, 100.60421575023001',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 360,
                height: 65,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.generating_tokens),
                        title: Text('จำนวนเหรียญที่ได้รับ : 0.25 เหรียญ'),
                        // subtitle:
                        //     Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 210,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewSelectedItem()));
                  },
                  child: const Text('คลิกดูรายการขยะ'),
                ),
              ),
              const SizedBox(height: 9),
              SizedBox(
                width: 210,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sendItemNearbyBin()));
                  },
                  child: const Text('กดเพื่อรับงาน'),
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
        ],
      ),
    );
  }
}
