import 'package:equatable/equatable.dart';
import 'package:task/core/base/base_model.dart';
import 'package:task/features/home/data/models/category_model.dart';
import 'package:task/features/home/data/models/product_model.dart';

class HomeDataModel extends Equatable implements BaseModel {
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  const HomeDataModel({required this.categories, required this.products});

  @override
  HomeDataModel fromMap(Map<String, dynamic> json) {
    return HomeDataModel(
      categories: (json['categories'] as List? ?? [])
          .map((e) => const CategoryModel(id: '', name: '').fromMap(e))
          .toList(),
      products: (json['products'] as List? ?? [])
          .map(
            (e) => const ProductModel(
              id: '',
              title: '',
              imageUrl: '',
              location: '',
              price: '',
            ).fromMap(e),
          )
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    'categories': categories.map((e) => e.toMap()).toList(),
    'products': products.map((e) => e.toMap()).toList(),
  };

  @override
  HomeDataModel copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
  }) {
    return HomeDataModel(
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  @override
  HomeDataModel fakeData() {
    return const HomeDataModel(
      categories: [
        CategoryModel(id: '1', name: 'Fake 1'),
        CategoryModel(id: '2', name: 'Fake 2'),
      ],
      products: [
        ProductModel(
          id: '1',
          title: 'Fake Product',
          imageUrl: '',
          location: 'Fake Location',
          price: '0',
        ),
      ],
    );
  }

  @override
  List<Object?> get props => [categories, products];
}
