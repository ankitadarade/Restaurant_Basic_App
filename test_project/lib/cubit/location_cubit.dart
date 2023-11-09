import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../state/location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationLoading());

  Future<void> getCurrentLocation() async {
    try {
      emit(LocationLoading());
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      emit(LocationLoaded(position: position));
    } catch (e) {
      emit(LocationError(errorMessage: 'Error getting location: $e'));
    }
  }

 
  void updateLocation(Position position) {
    emit(LocationLoaded(position: position));
  }
}
