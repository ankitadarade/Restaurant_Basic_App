import 'package:bloc/bloc.dart';
import '../state/category_state.dart';

class CategoryFiltersCubit extends Cubit<CategoryFiltersState> {
  CategoryFiltersCubit() : super(CategoryFiltersInitial());

  void toggleCategory(int index) {
    emit(CategoryFiltersToggled(index: index));
  }
}
