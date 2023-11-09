import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;

  const LocationLoaded({required this.position});

  @override
  List<Object> get props => [position];
}

class LocationError extends LocationState {
  final String errorMessage;

  const LocationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
