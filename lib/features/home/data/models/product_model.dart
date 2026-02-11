import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final String price;
  final String? categoryId;

  const ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.price,
    this.categoryId,
  });

  static String _toString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is num) return value.toString();
    return value.toString();
  }

  static String? _toStringOrNull(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    if (value is num) return value.toString();
    return value.toString();
  }

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> map) {
    return ProductModel(
      id: id,
      title: _toString(map['title']),
      imageUrl: _toString(map['imageUrl']),
      location: _toString(map['location']),
      price: _toString(map['price']),
      categoryId: _toStringOrNull(map['categoryId']),
    );
  }

  /// Price formatted for UI (e.g. "$120/night"). Handles raw numbers from Firestore.
  String get displayPrice {
    if (price.trim().isEmpty) return '';
    if (price.contains(r'$') || price.toLowerCase().contains('night')) {
      return price;
    }
    return '\$$price/night';
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'imageUrl': imageUrl,
        'location': location,
        'price': price,
        if (categoryId != null) 'categoryId': categoryId,
      };

  @override
  List<Object?> get props => [id, title, imageUrl, location, price, categoryId];
}
