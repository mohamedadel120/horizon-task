import 'package:equatable/equatable.dart';
import 'package:task/core/base/base_model.dart';

class ProductModel extends Equatable implements BaseModel {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final String price;
  final String? categoryId;
  final String description;
  final List<String> features;
  final double basePrice;
  final double cleaningFee;
  final double taxRate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.price,
    this.categoryId,
    this.description = '',
    this.features = const [],
    this.basePrice = 0.0,
    this.cleaningFee = 0.0,
    this.taxRate = 0.0,
    this.createdAt,
    this.updatedAt,
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

  static List<String> _toList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> map) {
    return ProductModel(
      id: id,
      title: _toString(
        map['name'] ?? map['title'],
      ), // Support 'name' (primary) or 'title' (legacy/fallback)
      imageUrl: _toString(map['imageUrl']),
      location: _toString(map['location']),
      price: _toString(map['price']),
      categoryId: _toStringOrNull(map['categoryId']),
      description: _toString(map['description']),
      features: _toList(map['features']),
      basePrice: _toDouble(map['basePrice']),
      cleaningFee: _toDouble(map['cleaningFee']),
      taxRate: _toDouble(map['taxRate']),
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt']
          : (map['createdAt'] != null
                ? (map['createdAt'] as dynamic).toDate()
                : null),
      updatedAt: map['updatedAt'] is DateTime
          ? map['updatedAt']
          : (map['updatedAt'] != null
                ? (map['updatedAt'] as dynamic).toDate()
                : null),
    );
  }

  @override
  ProductModel fromMap(Map<String, dynamic> json) {
    return ProductModel.fromFirestore(json['id'] ?? '', json);
  }

  @override
  Map<String, dynamic> toMap() => {
    'title': title,
    'imageUrl': imageUrl,
    'location': location,
    'price': price,
    if (categoryId != null) 'categoryId': categoryId,
    'description': description,
    'features': features,
    'basePrice': basePrice,
    'cleaningFee': cleaningFee,
    'taxRate': taxRate,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  @override
  ProductModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? location,
    String? price,
    String? categoryId,
    String? description,
    List<String>? features,
    double? basePrice,
    double? cleaningFee,
    double? taxRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      features: features ?? this.features,
      basePrice: basePrice ?? this.basePrice,
      cleaningFee: cleaningFee ?? this.cleaningFee,
      taxRate: taxRate ?? this.taxRate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  ProductModel fakeData() {
    return ProductModel(
      id: 'fake_id',
      title: 'Fake Product',
      imageUrl: 'https://via.placeholder.com/150',
      location: 'Fake Location',
      price: '100',
      description: 'This is a fake product description.',
      features: const ['2 Bedrooms', '1 Bath'],
      basePrice: 100.0,
      cleaningFee: 20.0,
      taxRate: 10.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
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

  @override
  List<Object?> get props => [
    id,
    title,
    imageUrl,
    location,
    price,
    categoryId,
    description,
    features,
    basePrice,
    cleaningFee,
    taxRate,
    createdAt,
    updatedAt,
  ];
}
