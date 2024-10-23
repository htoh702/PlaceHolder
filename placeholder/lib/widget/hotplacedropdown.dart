import 'package:flutter/material.dart';
import 'package:placeholder/services/api.dart';
import 'package:placeholder/services/model.dart';
import 'package:placeholder/globals.dart';

class HotPlaceDropdown extends StatefulWidget {
  @override
  _HotPlaceDropdownState createState() => _HotPlaceDropdownState();
}

class _HotPlaceDropdownState extends State<HotPlaceDropdown> {
  List<HotPlace> _data = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  HotPlace? _selectedPlace;

  Future<void> fetchData(String guName) async {
    try {
      final hotPlaces = await fetchHotPlaces(guName);
      setState(() {
        _data = hotPlaces;
        _selectedPlace = hotPlaces.isNotEmpty ? hotPlaces[0] : null;
        if (_selectedPlace != null) {
          selectedPlace.value = _selectedPlace;
        }
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sharedData.addListener(() {
      fetchData(sharedData.value);
    });
    fetchData(sharedData.value);
  }

  @override
  void dispose() {
    sharedData.removeListener(() {
      fetchData(sharedData.value);
    });
    super.dispose();
  }

  Color _getCongestionColor(String congestion) {
    switch (congestion) {
      case '붐빔':
        return Colors.red;
      case '약간 붐빔':
        return Colors.orange;
      case '보통':
        return Colors.yellow;
      case '여유':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _hasError
            ? Center(child: Text('Failed to load data: $_errorMessage'))
            : Container(
                width: 300,
                child: DropdownButton<HotPlace>(
                  isExpanded: true,
                  value: _selectedPlace,
                  onChanged: (HotPlace? newValue) {
                    setState(() {
                      _selectedPlace = newValue;
                      if (newValue != null) {
                        selectedPlace.value = newValue;
                      }
                    });
                  },
                  items:
                      _data.map<DropdownMenuItem<HotPlace>>((HotPlace place) {
                    return DropdownMenuItem<HotPlace>(
                      value: place,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${place.name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getCongestionColor(place.congestion),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              place.congestion,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
  }
}
