import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/widgets/card_design.dart';

import '../cubit/restaurant_cubit.dart';
import '../state/restaurant_state.dart';

class Restaurant {
  final int id;
  final String name;
  final String tags;
  final double rating;
  final int discount;
  final String primaryImage;
  final double distance;

  Restaurant({
    required this.id,
    required this.name,
    required this.tags,
    required this.rating,
    required this.discount,
    required this.primaryImage,
    required dynamic distance,
  }) : distance = distance is int ? distance.toDouble() : distance;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      tags: json['tags'] ?? '',
      rating: json['rating'] ?? 0.0,
      discount: json['discount'] ?? 0,
      primaryImage: json['primary_image'] ?? '',
      distance: json['distance'] ?? 0.0,
    );
  }
}

class NearbyRestaurantsWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  NearbyRestaurantsWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) =>
          RestaurantCubit()..fetchRestaurants(latitude, longitude),
      child: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.isError) {
            return Center(child: Text('Failed to load restaurants'));
          } else {
            final restaurants = state.restaurants;
            // print('Number of restaurants: ${restaurants.length}');
            return Container(
              height: h / 1.614,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return CardDesign(
                    name: restaurant.name,
                    imageUrl: restaurant.primaryImage,
                    distance: restaurant.distance,
                    rating: restaurant.rating,
                    discount: restaurant.discount,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
