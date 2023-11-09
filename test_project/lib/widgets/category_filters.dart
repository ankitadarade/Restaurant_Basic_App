import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubit/category_cubit.dart';
import '../state/category_state.dart';

class CategoryFiltersWidget extends StatelessWidget {
  var isSelected = null;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return BlocBuilder<CategoryFiltersCubit, CategoryFiltersState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            height: h / 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                if (isSelected == null) {
                  BlocProvider.of<CategoryFiltersCubit>(context)
                      .toggleCategory(0);
                }
                isSelected =
                    state is CategoryFiltersToggled && state.index == index;
                return InkWell(
                  onTap: () {
                    BlocProvider.of<CategoryFiltersCubit>(context)
                        .toggleCategory(index);
                  },
                  child: Container(
                    width: isSelected ? w * 0.25 : w * 0.2,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isSelected
                            ? Icon(category.icon, color: Colors.white)
                            : Icon(
                                category.icon,
                                color: Colors.black,
                              ),
                        if (isSelected) const SizedBox(width: 10),
                        if (isSelected)
                          Text(category.name,
                              style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

final List<Category> categories = [
  Category(name: 'All', icon: Icons.category),
  Category(name: 'Pizza', icon: FontAwesomeIcons.pizzaSlice),
  Category(name: 'Burger', icon: FontAwesomeIcons.burger),
  Category(name: 'Vegies', icon: FontAwesomeIcons.carrot),
  Category(name: 'Bread', icon: FontAwesomeIcons.breadSlice),
  Category(name: 'Salads', icon: FontAwesomeIcons.leaf),
  Category(name: 'Fruits', icon: FontAwesomeIcons.appleWhole),
];
