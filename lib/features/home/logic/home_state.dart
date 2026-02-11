import 'package:equatable/equatable.dart';
import 'package:task/features/home/data/models/category_model.dart';
import 'package:task/features/home/data/models/product_model.dart';

class HomeState extends Equatable {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final int selectedCategoryIndex;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.categories = const [],
    this.products = const [],
    this.selectedCategoryIndex = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  /// "All" is index 0; actual categories start at index 1.
  String? get selectedCategoryId {
    if (selectedCategoryIndex <= 0 || selectedCategoryIndex > categories.length) {
      return null;
    }
    return categories[selectedCategoryIndex - 1].id;
  }

  HomeState copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    int? selectedCategoryIndex,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [categories, products, selectedCategoryIndex, isLoading, errorMessage];
}
