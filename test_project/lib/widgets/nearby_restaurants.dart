import 'package:flutter/material.dart';
import 'package:test_project/widgets/card_design.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearbyRestaurantsWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  const NearbyRestaurantsWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  _NearbyRestaurantsWidgetState createState() =>
      _NearbyRestaurantsWidgetState();
}

class _NearbyRestaurantsWidgetState extends State<NearbyRestaurantsWidget> {
  List<Restaurant> restaurants = [];
  List<Restaurant> filteredRestaurants = [];

  TextEditingController searchController = TextEditingController();

  @override
  void didUpdateWidget(covariant NearbyRestaurantsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.latitude != oldWidget.latitude ||
        widget.longitude != oldWidget.longitude) {
      fetchRestaurants();
    }
  }

  Future<void> fetchRestaurants() async {
    final baseUrl = 'https://theoptimiz.com/restro/public/api/';
    final endPoint = 'get_resturants';

    final response = await http.post(
      Uri.parse('$baseUrl$endPoint'),
      body: jsonEncode({"lat": widget.latitude, "lng": widget.longitude}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsedResponse = json.decode(response.body);
      final List<dynamic> restaurantList = parsedResponse['data'];

      setState(() {
        restaurants =
            restaurantList.map((json) => Restaurant.fromJson(json)).toList();
      });
    } else {
      SnackBar(content: Text('Failed to load restaurants'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    
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
          );
        },
      ),
    );
  }
}

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
