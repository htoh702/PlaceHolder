import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:placeholder/globals.dart' as globals;
import 'package:placeholder/services/api.dart';
import 'package:placeholder/services/model.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? _controller;
  final LatLngBounds _seoulBounds = LatLngBounds(
    southwest: LatLng(37.4700, 126.8300),
    northeast: LatLng(37.7000, 127.1500),
  );

  late CameraPosition _initialPosition;
  Marker? _currentLocationMarker;
  Set<Marker> _parkingMarkers = {};
  Set<Marker> _categoryMarkers = {};
  BitmapDescriptor myLocationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor parkingNoMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor parkingYesMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor foodMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor cafeMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor playMarker = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _initializeInitialPosition();
    _setCurrentLocation();
    globals.selectedPlace.addListener(_moveToSelectedPlace);
    globals.parkingInfo.addListener(_updateParkingMarkers);
    globals.sharedData.addListener(_onSharedDataChanged);
    globals.sharedData.addListener(_onCategoryChanged);
    globals.selectedCategory.addListener(_onCategoryChanged);
    addCustomIcons();
  }

  @override
  void dispose() {
    globals.selectedPlace.removeListener(_moveToSelectedPlace);
    globals.parkingInfo.removeListener(_updateParkingMarkers);
    globals.sharedData.removeListener(_onSharedDataChanged);
    globals.sharedData.removeListener(_onCategoryChanged);
    globals.selectedCategory.removeListener(_onCategoryChanged);
    super.dispose();
  }

  void addCustomIcons() async {
    myLocationMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/marker/mylocation_marker.png");
    parkingNoMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/marker/parking_no_marker.png");
    parkingYesMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/marker/parking_yes_marker.png");
    foodMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/marker/food_marker.png");
    cafeMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/marker/cafe_marker.png");
    playMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/marker/play_marker.png");

    setState(() {});
  }

  void _initializeInitialPosition() {
    HotPlace? place = globals.selectedPlace.value;
    LatLng initialCenter;
    if (place != null) {
      double? mapX = place.mapx;
      double? mapY = place.mapy;
      if (mapX != null && mapY != null) {
        initialCenter = LatLng(mapY, mapX);
      } else {
        initialCenter = LatLng(37.5665, 126.9780);
      }
    } else {
      initialCenter = LatLng(37.5665, 126.9780);
    }
    setState(() {
      _initialPosition = CameraPosition(target: initialCenter, zoom: 15);
    });
  }

  Future<void> _setCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocationMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
        icon: myLocationMarker,
        infoWindow: const InfoWindow(title: '현재 위치'),
      );
    });
  }

  void _onSharedDataChanged() {
    if (globals.parkingInfo.value) {
      _updateParkingMarkers();
    }
  }

  Future<void> _updateParkingMarkers() async {
    if (globals.parkingInfo.value) {
      String gu = globals.sharedData.value;
      List<ParkingLot> parkingLots = await parkingplaces(gu);
      Set<Marker> newMarkers = {};
      for (var parkingLot in parkingLots) {
        double mapX = double.parse(parkingLot.mapx);
        double mapY = double.parse(parkingLot.mapy);
        bool isCapacityEqual = parkingLot.capacity == parkingLot.curParking;
        Marker marker = Marker(
          markerId: MarkerId(parkingLot.hotplace_sort_key),
          position: LatLng(mapY, mapX),
          icon: isCapacityEqual ? parkingNoMarker : parkingYesMarker,
          infoWindow: InfoWindow(title: parkingLot.name),
        );
        newMarkers.add(marker);
      }
      setState(() {
        _parkingMarkers = newMarkers;
      });
    } else {
      setState(() {
        _parkingMarkers.clear();
      });
    }
  }

  void _onCategoryChanged() {
    print('Category changed to ${globals.selectedCategory.value}');
    _updateCategoryMarkers();
  }

  Future<void> _updateCategoryMarkers() async {
    print('Updating category markers');
    String category = globals.selectedCategory.value;
    String gu = globals.sharedData.value;
    print('Selected category: $category');

    List<CategoryPlaceDetail> categoryPlaces;

    Set<Marker> newMarkers = {};

    BitmapDescriptor markerIcon;
    if (category == '음식점') {
      markerIcon = foodMarker;
      try {
        categoryPlaces = await restaurantPlacesDetail(gu);
        print('Number of places: ${categoryPlaces.length}');
      } catch (e) {
        print('Error fetching category places: $e');
        return;
      }
    } else if (category == '카페') {
      markerIcon = cafeMarker;
      try {
        categoryPlaces = await cafePlacesDetail(gu);
        print('Number of places: ${categoryPlaces.length}');
      } catch (e) {
        print('Error fetching category places: $e');
        return;
      }
    } else if (category == '놀거리') {
      markerIcon = playMarker;
      try {
        categoryPlaces = await enterPlacesDetail(gu);
        print('Number of places: ${categoryPlaces.length}');
      } catch (e) {
        print('Error fetching category places: $e');
        return;
      }
    } else {
      markerIcon = BitmapDescriptor.defaultMarker;
      print('Error fetching');
      return;
    }

    for (var place in categoryPlaces) {
      double? mapX = double.tryParse(place.mapX);
      double? mapY = double.tryParse(place.mapY);
      if (mapX != null && mapY != null) {
        Marker marker = Marker(
          markerId: MarkerId(place.hotplaceSortKey),
          position: LatLng(mapY, mapX),
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: place.name,
            onTap: () async {
              CategoryPlaceDetail placeDetail = await fetchPlaceDetail(
                  place.hotplacePartitionKey,
                  place.hotplaceSortKey.replaceFirst('Place#', ''));
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(placeDetail.name),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Address: ${placeDetail.address ?? "N/A"}'),
                        Text('Category: ${placeDetail.category}'),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: placeDetail.imageUrl != null
                              ? Image.network(
                                  placeDetail.imageUrl!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : Center(
                                            child: CircularProgressIndicator());
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                        child: Text('Failed to load image'));
                                  },
                                )
                              : Center(child: Text('No image available')),
                        ),
                        SizedBox(height: 10),
                        placeDetail.placeUrl != null
                            ? GestureDetector(
                                onTap: () async {
                                  final url = placeDetail.placeUrl!;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(
                                  'URL: ${placeDetail.placeUrl}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            : Text('No URL available'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
        newMarkers.add(marker);
        print('Added marker: ${place.name} at ($mapY, $mapX)');
      } else {
        print('Error parsing coordinates for place: ${place.name}');
      }
    }

    setState(() {
      _categoryMarkers = newMarkers;
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    await _controller!.setMapStyle(
        '[{"featureType": "poi", "elementType": "labels", "stylers": [{"visibility": "off"}]}]');
    await _controller!
        .animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
    await _controller!
        .animateCamera(CameraUpdate.newLatLngBounds(_seoulBounds, 0));
  }

  void _onCameraMove(CameraPosition position) {
    if (_controller != null && !_seoulBounds.contains(position.target)) {
      double lat = position.target.latitude;
      double lng = position.target.longitude;

      if (lat < _seoulBounds.southwest.latitude) {
        lat = _seoulBounds.southwest.latitude + 0.001;
      } else if (lat > _seoulBounds.northeast.latitude) {
        lat = _seoulBounds.northeast.latitude - 0.001;
      }

      if (lng < _seoulBounds.southwest.longitude) {
        lng = _seoulBounds.southwest.longitude + 0.001;
      } else if (lng > _seoulBounds.northeast.longitude) {
        lng = _seoulBounds.northeast.longitude - 0.001;
      }

      LatLng correctedLatLng = LatLng(lat, lng);
      _controller!.animateCamera(CameraUpdate.newLatLng(correctedLatLng));
    }
  }

  void _moveToSelectedPlace() {
    HotPlace? place = globals.selectedPlace.value;
    if (place != null && _controller != null) {
      double? mapX = place.mapx;
      double? mapY = place.mapy;
      if (mapX != null && mapY != null) {
        LatLng position = LatLng(mapY, mapX);
        print('Moving to selected place: mapX=$mapX, mapY=$mapY');
        _controller!.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
      } else {
        print('Error parsing selected place coordinates.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> allMarkers = {
      ..._parkingMarkers,
      ..._categoryMarkers,
    };

    if (_currentLocationMarker != null) {
      allMarkers.add(_currentLocationMarker!);
    }

    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: _onMapCreated,
      markers: allMarkers,
      cameraTargetBounds: CameraTargetBounds(_seoulBounds),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onCameraMove: _onCameraMove,
      minMaxZoomPreference: const MinMaxZoomPreference(13, 16),
    );
  }
}
