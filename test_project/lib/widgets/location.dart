import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../cubit/location_cubit.dart';
import '../state/location_state.dart';

class LocationServiceWidget extends StatefulWidget {
  final void Function(double latitude, double longitude) onLocationChanged;

  const LocationServiceWidget({Key? key, required this.onLocationChanged})
      : super(key: key);

  @override
  _LocationServiceWidgetState createState() => _LocationServiceWidgetState();
}

class _LocationServiceWidgetState extends State<LocationServiceWidget> {
  String? _locationName;
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle if the user doesn't grant location permissions
        return;
      }
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String locationName = placemarks.isNotEmpty
          ? placemarks[0].name ?? "Unknown Location"
          : "Unknown Location";

      setState(() {
        _locationName = locationName;
      });

      widget.onLocationChanged(position.latitude, position.longitude);
      BlocProvider.of<LocationCubit>(context).updateLocation(position);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Padding(
            padding:  EdgeInsets.all(18.0),
            child: Text('Loading location...',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          );
        } else if (state is LocationLoaded) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on),
                Text('Location: $_locationName',
                    style:
                        const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        } else if (state is LocationError) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return const Text('Unknown state');
        }
      },
    );
  }
}
