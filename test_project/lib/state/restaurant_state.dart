import '../widgets/nearby_restaurants.dart';

class RestaurantState {
  final List<Restaurant> restaurants;
  final bool isLoading;
  final bool isError;

  RestaurantState({
    required this.restaurants,
    required this.isLoading,
    required this.isError,
  });

  factory RestaurantState.initial() {
    return RestaurantState(
      restaurants: [],
      isLoading: false,
      isError: false,
    );
  }

  factory RestaurantState.loading() {
    return RestaurantState(
      restaurants: [],
      isLoading: true,
      isError: false,
    );
  }

  factory RestaurantState.success(List<Restaurant> restaurants) {
    return RestaurantState(
      restaurants: restaurants,
      isLoading: false,
      isError: false,
    );
  }

  factory RestaurantState.error() {
    return RestaurantState(
      restaurants: [],
      isLoading: false,
      isError: true,
    );
  }
}
