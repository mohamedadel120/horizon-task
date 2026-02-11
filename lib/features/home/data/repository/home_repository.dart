import 'package:task/features/home/data/datasources/home_firestore_service.dart';
import 'package:task/features/home/data/models/category_model.dart';
import 'package:task/features/home/data/models/product_model.dart';

class HomeRepository {
  HomeRepository(this._firestoreService);

  final HomeFirestoreService _firestoreService;

  Future<void> seedIfEmpty() => _firestoreService.seedIfEmpty();

  Future<List<CategoryModel>> getCategories() =>
      _firestoreService.getCategories();

  Future<List<ProductModel>> getProducts({String? categoryId}) =>
      _firestoreService.getProducts(categoryId: categoryId);
}
