import 'package:garbage_collection_reminder/model/collection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CollectionController extends GetxController {
  var collectionList = <Collection>[].obs;
  var isLoading = false.obs;
  var failed = false.obs;
  var error = Exception();

  fetchCollection() async {
    this.isLoading.value = true;
    final currentLocation = await _determineLocation();
    final addressesFromLocation = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    if (addressesFromLocation.isEmpty) {
      this.failed.value = true;
      error = Exception('Unable to fetch address based on current location');
      return;
    }
    final currentPlacemark = addressesFromLocation.first;
    if (currentPlacemark.locality != "Calgary") {
      this.failed.value = true;
      error = Exception("This app only supports Calgary area");
      return;
    }

    try {
      final response = await http.get(
          'https://data.calgary.ca/resource/jq4t-b745.json?\$where=within_circle(location, ${currentLocation.latitude}, ${currentLocation.longitude}, 50)&\$order=address&\$limit=3');

      // Use the compute function to run parsePhotos in a separate isolate.
      final normalList = await compute(_parseGarbageCollection, response.body);
      this.collectionList = normalList.obs;
    } catch(_) {
      this.failed.value = true;
      error = Exception("Failed to fetch data");
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  // A function that converts a response body into a List<Photo>.
  List<Collection> _parseGarbageCollection(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Collection>((json) => Collection.fromJson(json)).toList();
  }

}