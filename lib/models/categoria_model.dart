class Categoria {
  final int categoryId;
  final String categoryName;
  final String categoryState;

  Categoria({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      categoryId: map['category_id'],
      categoryName: map['category_name'],
      categoryState: map['category_state'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'category_state': categoryState,
    };
  }
}
