import 'package:equatable/equatable.dart';
import 'package:task/core/base/cubit/base_state.dart';
import 'package:task/features/home/data/models/category_model.dart';
import 'package:task/features/home/data/models/product_model.dart';

class HomeState extends Equatable implements BaseState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final int selectedCategoryIndex;
  final String userName;
  final String avatarUrl;
  @override
  final Map<String, BaseApiState> apiStates;

  const HomeState({
    this.categories = const [],
    this.products = const [],
    this.selectedCategoryIndex = 0,
    this.userName = 'User',
    this.avatarUrl = '',
    this.apiStates = const {},
  });

  /// "All" is index 0; actual categories start at index 1.
  String? get selectedCategoryId {
    if (selectedCategoryIndex <= 0 ||
        selectedCategoryIndex > categories.length) {
      return null;
    }
    return categories[selectedCategoryIndex - 1].id;
  }

  @override
  HomeState copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    int? selectedCategoryIndex,
    String? userName,
    String? avatarUrl,
    Map<String, BaseApiState>? apiStates,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      userName: userName ?? this.userName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      apiStates: apiStates ?? this.apiStates,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    products,
    selectedCategoryIndex,
    userName,
    avatarUrl,
    apiStates,
  ];

  // BaseState implementation helpers (forwarding to mixin or manually implementing if BaseState was a class)
  // BaseState is an abstract class with implemented methods. Equality doesn't mix well with inheritance if not careful.
  // Dart doesn't support multiple inheritance.
  // BaseState is a class?
  // Abstract class BaseState { final Map...; ... methods }
  // If I extends Equatable, I cannot extends BaseState (class).
  // I must IMPLEMENT BaseState if it's an interface, or Use Mixin.
  // BaseState is an abstract class.
  // Logic:
  // class HomeState extends BaseState with EquatableMixin?
  // Or class HomeState extends Equatable implements BaseState?
  // If implements, I must copy paste getStatus, etc.

  @override
  BaseStatus getStatus(String operation) =>
      apiStates[operation]?.status ?? BaseStatus.initial;

  @override
  String? getError(String operation) => apiStates[operation]?.error;

  @override
  dynamic getData(String operation) => apiStates[operation]?.responseModel;

  @override
  BaseApiState getApiState(String operation) =>
      apiStates[operation] ??
      BaseApiState(
        status: BaseStatus.initial,
        error: null,
        responseModel: null,
      );
}
