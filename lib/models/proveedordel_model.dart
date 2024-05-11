class ProveedorDel {
  final int providerId;

  ProveedorDel({
    required this.providerId,
  });

  factory ProveedorDel.fromMap(Map<String, dynamic> map) {
    return ProveedorDel(
      providerId: map['provider_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'provider_id': providerId,
    };
  }
}
