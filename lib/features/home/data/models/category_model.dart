import 'package:equatable/equatable.dart';
import 'package:task/core/base/base_model.dart';

class CategoryModel extends Equatable implements BaseModel {
  final String id;
  final String name;
  final int order;

  const CategoryModel({required this.id, required this.name, this.order = 0});

  factory CategoryModel.fromFirestore(String id, Map<String, dynamic> map) {
    final orderRaw = map['order'];
    int order = 0;
    if (orderRaw != null) {
      if (orderRaw is num) order = orderRaw.toInt();
      if (orderRaw is String) order = int.tryParse(orderRaw) ?? 0;
    }
    final nameRaw = map['name'];
    final name = nameRaw is String ? nameRaw : (nameRaw?.toString() ?? '');
    return CategoryModel(id: id, name: name, order: order);
  }

  @override
  CategoryModel fromMap(Map<String, dynamic> json) {
    return CategoryModel.fromFirestore(json['id'] ?? '', json);
  }

  @override
  Map<String, dynamic> toMap() => {'name': name, 'order': order};

  @override
  CategoryModel copyWith({String? id, String? name, int? order}) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
    );
  }

  @override
  CategoryModel fakeData() {
    return const CategoryModel(id: 'fake_id', name: 'Fake Category', order: 0);
  }

  @override
  List<Object?> get props => [id, name, order];
}
