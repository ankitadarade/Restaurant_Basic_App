import 'package:flutter/material.dart';

class CardDesign extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double distance;
  final double rating;
  final int discount;

  const CardDesign({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.distance,
    required this.rating,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: h / 4.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                            imageUrl,
                          ),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  top: h / 6,
                  left: w / 1.34,
                  child: Container(
                    height: h / 25,
                    width: w / 6,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: w / 50,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: w / 25,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // const SizedBox(width: 60),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(children: [
                    const Image(
                      image: AssetImage("assets/Discount.png"),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "${discount.toString()}% FLAT OFF",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${distance.toStringAsFixed(2)} meters away',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
