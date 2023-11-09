import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/widgets/location.dart';
import './cubit/location_cubit.dart';
import './cubit/category_cubit.dart';
import './widgets/search_bar.dart';
import './widgets/category_filters.dart';
import './widgets/nearby_restaurants.dart';
import './widgets/bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: BlocProvider(
        create: (context) => LocationCubit(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (BuildContext context) => LocationCubit(),
        ),
        BlocProvider<CategoryFiltersCubit>(
          create: (BuildContext context) => CategoryFiltersCubit(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          shadowColor: Colors.red.shade900,
          backgroundColor: Colors.redAccent.withOpacity(0.7),
          leading: Icon(
            Icons.restaurant_rounded,
            size: 30,
          ),
          title: Text('NearBy Restaurants'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red.withOpacity(0.3),
                Colors.red.withOpacity(0.2),
                Colors.white.withOpacity(0.2),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                LocationServiceWidget(
                  onLocationChanged: (lat, long) {
                    setState(() {
                      latitude = lat;
                      longitude = long;
                    });
                  },
                ),
                CategoryFiltersWidget(),
                SearchBarWidget(),
                NearbyRestaurantsWidget(
                  latitude: latitude,
                  longitude: longitude,
                ),
                // Other widgets
              ],
            ),
          ),
        ),
        bottomNavigationBar: CurvedBottomNavigationWidget(
          selectedIndex: 2,
          onTabTapped: (index) {
            // Handle bottom navigation tap
          },
        ),
      ),
    );
  }
}
