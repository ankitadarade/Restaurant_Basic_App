

abstract class CategoryFiltersState {
  const CategoryFiltersState();
}

class CategoryFiltersInitial extends CategoryFiltersState {
  const CategoryFiltersInitial();
}

class CategoryFiltersToggled extends CategoryFiltersState {
  final int index;

  const CategoryFiltersToggled({required this.index});
}
