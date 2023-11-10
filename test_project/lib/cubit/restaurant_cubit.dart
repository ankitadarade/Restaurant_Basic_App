import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../state/restaurant_state.dart';
import '../widgets/nearby_restaurants.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit() : super(RestaurantState.initial());

  void fetchRestaurants(double latitude, double longitude) async {
    emit(RestaurantState.loading());

    final baseUrl = 'https://theoptimiz.com/restro/public/api/';
    final endPoint = 'get_resturants';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endPoint'),
        body: jsonEncode({"lat": latitude, "lng": longitude}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedResponse = json.decode(response.body);
        final List<dynamic> restaurantList = parsedResponse['data'];

        final restaurants = restaurantList.map((json) => Restaurant.fromJson(json)).toList();
        emit(RestaurantState.success(restaurants));
      } else {
        emit(RestaurantState.error());
      }
    } catch (e) {
      emit(RestaurantState.error());
    }
  }
}
