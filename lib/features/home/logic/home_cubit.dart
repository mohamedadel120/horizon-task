import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/base/cubit/base_cubit.dart';
import 'package:task/features/home/data/models/home_data_model.dart';
import 'package:task/features/home/data/repository/home_repository.dart';
import 'package:task/features/home/logic/home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState()) {
    _initUser();
  }

  final HomeRepository _repository;

  static const String loadHomeData = 'loadHomeData';

  void _initUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(
        state.copyWith(
          userName: user.displayName ?? 'User',
          avatarUrl: user.photoURL ?? '',
        ),
      );
    }
  }

  Future<void> loadCategoriesAndProducts() async {
    handleApiCall<HomeDataModel>(
      endPoint: loadHomeData,
      apiCall: () => _repository.getHomeData(),
    );
  }

  /// Override handleApiCall results if needed?
  /// BaseCubit.handleApiCall automatically emits status and responseModel.
  /// But we also want to update categories/products in the top-level state
  /// for child widgets that don't use BaseBlocBuilder.
  @override
  void successOperation(String operation, {dynamic data}) {
    if (operation == loadHomeData && data is HomeDataModel) {
      emit(
        state.copyWith(categories: data.categories, products: data.products),
      );
    }
    super.successOperation(operation, data: data);
  }

  Future<void> selectCategory(int index) async {
    if (index == state.selectedCategoryIndex) return;

    emit(state.copyWith(selectedCategoryIndex: index));

    final categoryId = state.selectedCategoryId;

    // Load products for selected category
    handleApiCall(
      endPoint:
          loadHomeData, // Reuse endpoint for simplicity in BaseBlocBuilder
      apiCall: () async {
        final result = await _repository.getProductsForCategory(
          categoryId: categoryId,
        );
        return result.map(
          (products) =>
              HomeDataModel(categories: state.categories, products: products),
        );
      },
    );
  }
}
