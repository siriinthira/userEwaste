// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetMap extends StatelessWidget {
  const WidgetMap({
    Key? key,
    required this.position,
    required this.setMarkers,
  }) : super(key: key);

  final Position position;
  final Set<Marker> setMarkers;

  @override
  Widget build(BuildContext context) {
    print('@@@WidgetMap position --> $position');
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12,
      ),
      onMapCreated: (controller) {},
      markers: setMarkers,
    );
  }
}
