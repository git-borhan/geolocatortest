import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geocoding_platform_interface/src/models/placemark.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? address;
  String? latitude;
  String? longitude;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("Permission not given");
      LocationPermission askedForLocation =
      await Geolocator.requestPermission();
    } else {
      Position currentPosition =
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      latitude = currentPosition.latitude.toString();
      longitude = currentPosition.longitude.toString();
      print("Latitude: $latitude");
      print("Longitude: $longitude");

      // Perform geocoding to get the address from coordinates
      List<Placemark> placemarks = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      // Extract the address from the first placemark
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String? formattedAddress = placemark.country;
        if (formattedAddress != null) {
          address = formattedAddress;
          print("Address: $address");
        } else {
          print("No address found");
        }
      } else {
        print("No placemarks found");
      }
    }

    setState(() {}); // Update the state to trigger a rebuild with the address
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getCurrentPosition,
              child: const Text("Geo Locator Track"),
            ),
            const SizedBox(height: 16),
            Text("Latitude: $latitude"),
            Text("Longitude: $longitude"),
            Text("Address: $address"),
            Text("Check Data"),
            Text("Check Data"),
            Text("Check Data"),
            Text("Check Data"),
            Text("Check Data"),
          ],
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? address;
  String? latitude;
  String? longitude;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("Permission not given");
      LocationPermission askedForLocation =
      await Geolocator.requestPermission();
    } else {
      Position currentPosition =
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      latitude = currentPosition.latitude.toString();
      longitude = currentPosition.longitude.toString();
      print("Latitude: $latitude");
      print("Longitude: $longitude");

      // Perform geocoding to get the address from coordinates
      List<geocoding.Placemark> placemarks =
      await geocoding.placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );

      // Extract the address from the first placemark
      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks.first;
        String? formattedAddress = placemark.street;
        if (formattedAddress != null) {
          address = formattedAddress;
          print("Address: $address");
        } else {
          print("No address found");
        }
      } else {
        print("No placemarks found");
      }
    }

    setState(() {}); // Update the state to trigger a rebuild with the address
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getCurrentPosition,
              child: const Text("Geo Locator Track"),
            ),
            const SizedBox(height: 16),
            Text("Latitude: $latitude"),
            Text("Longitude: $longitude"),
            Text("Address: $address"),
          ],
        ),
      ),
    );
  }
}*/