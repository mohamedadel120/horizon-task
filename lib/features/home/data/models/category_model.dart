import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final int order;

  const CategoryModel({
    required this.id,
    required this.name,
    this.order = 0,
  });

  factory CategoryModel.fromFirestore(String id, Map<String, dynamic> map) {
    final orderRaw = map['order'];
    int order = 0;
    if (orderRaw != null) {
      if (orderRaw is num) order = orderRaw.toInt();
      if (orderRaw is String) order = int.tryParse(orderRaw) ?? 0;
    }
    final nameRaw = map['name'];
    final name = nameRaw is String ? nameRaw : (nameRaw?.toString() ?? '');
    return CategoryModel(
      id: id,
      name: name,
      order: order,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'order': order,
      };

  @override
  List<Object?> get props => [id, name, order];
}
