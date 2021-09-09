import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qr_reader/models/scan_model.dart';

const double CAMERA_ZOOM = 17;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapType _mapType = MapType.normal;

  Completer<GoogleMapController> _controller = new Completer();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: CAMERA_ZOOM,
    );

    // Marcadores
    Set<Marker> _markers = new Set<Marker>.unmodifiable([
      new Marker(
        markerId: MarkerId('geo-initial-point'),
        position: scan.getLatLng(),
      )
    ]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mapa'),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              await controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: scan.getLatLng(),
                  zoom: CAMERA_ZOOM,
                ),
              ));
            },
            icon: Icon(Icons.place),
          )
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        markers: _markers,
        mapType: _mapType,
        initialCameraPosition: _initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _mapType =
                _mapType == MapType.normal ? MapType.satellite : MapType.normal;
          });
        },
        child: Icon(Icons.layers),
      ),
    );
  }
}
