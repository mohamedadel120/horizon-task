import 'package:dartz/dartz.dart';
import 'package:task/core/base/base_repository.dart';
import 'package:task/core/errors/failures/failures.dart';
import 'package:task/features/home/data/datasources/home_firestore_service.dart';
import 'package:task/features/home/data/models/home_data_model.dart';
import 'package:task/features/home/data/models/product_model.dart';

class HomeRepository extends BaseRepository {
  HomeRepository(this._firestoreService);

  final HomeFirestoreService _firestoreService;

  Future<void> seedIfEmpty() => _firestoreService.seedIfEmpty();

  Future<Either<GFailure, HomeDataModel>> getHomeData() async {
    return safeCall(() async {
      final categories = await _firestoreService.getCategories();
      final products = await _firestoreService.getProducts();
      return HomeDataModel(categories: categories, products: products);
    });
  }

  Future<Either<GFailure, List<ProductModel>>> getProductsForCategory({
    String? categoryId,
  }) async {
    return safeCall(() async {
      return await _firestoreService.getProducts(categoryId: categoryId);
    });
  }
}
