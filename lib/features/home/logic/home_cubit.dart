import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/home/data/repository/home_repository.dart';
import 'package:task/features/home/logic/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final HomeRepository _repository;

  Future<void> loadCategoriesAndProducts() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _repository.seedIfEmpty();
      final categories = await _repository.getCategories();
      final categoryId = state.selectedCategoryIndex == 0
          ? null
          : (state.selectedCategoryIndex <= categories.length
              ? categories[state.selectedCategoryIndex - 1].id
              : null);
      final products = await _repository.getProducts(categoryId: categoryId);
      emit(state.copyWith(
        categories: categories,
        products: products,
        isLoading: false,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> selectCategory(int index) async {
    if (index == state.selectedCategoryIndex) return;
    emit(state.copyWith(selectedCategoryIndex: index));
    await _loadProductsForSelectedCategory();
  }

  Future<void> _loadProductsForSelectedCategory() async {
    final categoryId = state.selectedCategoryId;
    try {
      final products =
          await _repository.getProducts(categoryId: categoryId);
      emit(state.copyWith(products: products, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
