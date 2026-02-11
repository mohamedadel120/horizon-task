import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/features/home/data/models/category_model.dart';
import 'package:task/features/home/data/models/product_model.dart';

class HomeFirestoreService {
  HomeFirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  static const String _categoriesCollection = 'categories';
  static const String _productsCollection = 'products';

  /// Seeds example categories and products when collections are empty.
  Future<void> seedIfEmpty() async {
    final categoriesSnap =
        await _firestore.collection(_categoriesCollection).limit(1).get();
    if (categoriesSnap.docs.isNotEmpty) return;

    final batch = _firestore.batch();

    final popularRef =
        _firestore.collection(_categoriesCollection).doc();
    batch.set(popularRef, {'name': 'Popular', 'order': 0});

    final recentRef =
        _firestore.collection(_categoriesCollection).doc();
    batch.set(recentRef, {'name': 'Recent', 'order': 1});

    final favoritesRef =
        _firestore.collection(_categoriesCollection).doc();
    batch.set(favoritesRef, {'name': 'Favorites', 'order': 2});

    await batch.commit();

    final productBatch = _firestore.batch();
    final popularId = popularRef.id;
    final recentId = recentRef.id;
    final favoritesId = favoritesRef.id;

    final products = [
      {
        'title': 'Modern Loft',
        'imageUrl':
            'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400',
        'location': 'Central District',
        'price': '\$120/night',
        'categoryId': popularId,
      },
      {
        'title': 'Woodland Cabin',
        'imageUrl':
            'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=400',
        'location': 'North Hills',
        'price': '\$85/night',
        'categoryId': popularId,
      },
      {
        'title': 'Beachside Suite',
        'imageUrl':
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400',
        'location': 'Coastal Bay',
        'price': '\$200/night',
        'categoryId': popularId,
      },
      {
        'title': 'City Studio',
        'imageUrl':
            'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400',
        'location': 'Downtown',
        'price': '\$95/night',
        'categoryId': recentId,
      },
      {
        'title': 'Lakeside Retreat',
        'imageUrl':
            'https://images.unsplash.com/photo-1518780664697-55e3ad937233?w=400',
        'location': 'Green Valley',
        'price': '\$150/night',
        'categoryId': favoritesId,
      },
    ];

    for (final data in products) {
      final ref = _firestore.collection(_productsCollection).doc();
      productBatch.set(ref, data);
    }
    await productBatch.commit();
  }

  Future<List<CategoryModel>> getCategories() async {
    final snapshot =
        await _firestore.collection(_categoriesCollection).get();

    final list = snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc.id, doc.data()))
        .toList();
    list.sort((a, b) => a.order.compareTo(b.order));
    return list;
  }

  Future<List<ProductModel>> getProducts({String? categoryId}) async {
    Query<Map<String, dynamic>> query =
        _firestore.collection(_productsCollection);

    if (categoryId != null && categoryId.isNotEmpty) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }
}
