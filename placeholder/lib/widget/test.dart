import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:placeholder/globals.dart';
import 'package:placeholder/provider.dart';
import 'package:placeholder/services/api.dart';
import 'package:placeholder/services/model.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class TestApiServer extends StatefulWidget {
  @override
  State<TestApiServer> createState() => _TestApiServerState();
}

class _TestApiServerState extends State<TestApiServer> {
  @override
  Widget build(BuildContext context) {
    return MapScreen();
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  double course1X = 0;
  double course1Y = 0;
  double course2X = 0;
  double course2Y = 0;
  double course3X = 0;
  double course3Y = 0;

  Map<MarkerId, Marker> markers = {};
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _fetchLocations();
    _fetchDirections();
  }

  Future<void> _fetchLocations() async {
    final courseLocation =
        Provider.of<CourseLocationXY>(context, listen: false);
    course1X = courseLocation.course1X;
    course1Y = courseLocation.course1Y;
    course2X = courseLocation.course2X;
    course2Y = courseLocation.course2Y;
    course3X = courseLocation.course3X;
    course3Y = courseLocation.course3Y;

    _addMarker(LatLng(startY.value, startX.value), "start",
        await _createCustomMarkerBitmap('S'));
    _addMarker(LatLng(course1Y, course1X), "course1",
        await _createCustomMarkerBitmap('1'));
    _addMarker(LatLng(course2Y, course2X), "course2",
        await _createCustomMarkerBitmap('2'));
    _addMarker(LatLng(course3Y, course3X), "course3",
        await _createCustomMarkerBitmap('3'));
  }

  Future<void> _fetchDirections() async {
    final request = DirectionsRequest(
      originX: startX.value,
      originY: startY.value,
      destinationX: course3X,
      destinationY: course3Y,
      waypoints: [
        Waypoint(name: 'name0', x: course1X, y: course1Y),
        Waypoint(name: 'name1', x: course2X, y: course2Y)
      ],
      priority: 'RECOMMEND',
      alternatives: false,
      roadDetails: false,
    );

    try {
      final response = await getDirections(request);
      print('Directions fetched successfully');
      print('Transaction ID: ${response.transId}');

      List<LatLng> newPolylineCoordinates = [];

      for (var route in response.routes) {
        for (var section in route.sections) {
          for (var road in section.roads) {
            for (int i = 0; i < road.vertexes.length; i += 2) {
              newPolylineCoordinates.add(
                LatLng(road.vertexes[i + 1], road.vertexes[i]),
              );
            }
          }
        }
      }

      setState(() {
        polylineCoordinates = newPolylineCoordinates;
      });
    } catch (e) {
      print('Failed to fetch directions: $e');
    }
  }

  Future<BitmapDescriptor> _createCustomMarkerBitmap(String text) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = const Color(0xFFFF9C7B);
    final Radius radius = Radius.circular(5.0);
    final double width = 15.0;
    final double height = 15.0;

    // Draw the circle background
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, width, height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      paint,
    );

    // Draw the text
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    painter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 5.0,
        color: Colors.black,
      ),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset((width * 0.5) - painter.width * 0.5,
          (height * 0.5) - painter.height * 0.5),
    );

    final img = await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Container(
        height: 500,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              (startY.value + course1Y + course2Y + course3Y) / 4,
              (startX.value + course1X + course2X + course3X) / 4,
            ),
            zoom: 14,
          ),
          myLocationEnabled: false,
          tiltGesturesEnabled: false,
          compassEnabled: true,
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: {
            Polyline(
              polylineId: PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.red,
              width: 5,
            ),
          },
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
}
