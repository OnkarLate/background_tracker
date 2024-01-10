import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;


class LocationUpdateScreen extends StatefulWidget {
  @override
  _LocationUpdateScreenState createState() => _LocationUpdateScreenState();
}

class _LocationUpdateScreenState extends State<LocationUpdateScreen> {
  Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  double? lat;
  double? lon;

  @override
  void initState() {
    super.initState();
    startLocationUpdates();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  void startLocationUpdates() {
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
          // Update UI or send the location data to the server
          setState(() {
            lat = currentLocation.latitude;
            lon = currentLocation.longitude;
          });

          sendLocationToServer(
              currentLocation.latitude!, currentLocation.longitude!);
        });
  }

  Future<void> sendLocationToServer(double latitude, double longitude) async {
    final url = Uri.parse('https://machinetest.encureit.com/locationapi.php');
    final response = await http.post(
      url,
      body: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString()
      },
    );

    if (response.statusCode == 200) {
      print('Location sent successfully');
    } else {
      print('Failed to send location. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Update App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Latitude: ${lat ?? "N/A"}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Longitude: ${lon ?? "N/A"}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
