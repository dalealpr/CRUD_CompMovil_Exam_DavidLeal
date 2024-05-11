class Producto {
  final int productId;
  final String productName;
  final int productPrice;
  final String productImage;
  final String productState;

  Producto({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productState,
  });

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      productId: map['product_id'],
      productName: map['product_name'],
      productPrice: map['product_price'],
      productImage: map['product_image'],
      productState: map['product_state'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_price': productPrice,
      'product_image': productImage,
      'product_state': productState,
    };
  }
}
