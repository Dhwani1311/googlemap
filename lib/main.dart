import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController googleMapController;
  Location _location = Location();
  static final LatLng _center = LatLng(21.2021, 72.8673);

  LatLng _currentMapPosition = _center;

  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // _location.onLocationChanged.listen((l) {
    //   controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
    //     ),
    //   );
    // });
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_currentMapPosition.toString()),
          position: _currentMapPosition,
          // infoWindow: InfoWindow(
          //     //title: 'Nice Place'
          // ),
          icon: BitmapDescriptor. defaultMarkerWithHue(BitmapDescriptor.hueRed)
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Google Map')),
        ),
        body: Stack(
          children: <Widget>[
            // GoogleMap(
            //   initialCameraPosition: CameraPosition(target: _currentMapPosition),
            //   mapType: MapType.normal,
            //   onMapCreated: _onMapCreated,
            //   myLocationEnabled: true,
            // ),
            GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers,
                onCameraMove: _onCameraMove,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.0,
                ),
                mapType: _currentMapType
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 25.0),
                    ),
                    SizedBox(height: 10,),
                        FloatingActionButton(
                          onPressed: _onAddMarkerButtonPressed,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.add_location, size: 25.0),
                        ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}