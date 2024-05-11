class ProductoDel {
  final int productId;

  ProductoDel({
    required this.productId,
  });

  factory ProductoDel.fromMap(Map<String, dynamic> map) {
    return ProductoDel(
      productId: map['product_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
    };
  }
}
