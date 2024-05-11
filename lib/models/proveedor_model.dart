class Proveedor {
  final int providerId;
  final String providerName;
  final String providerLastName;
  final String providerMail;
  final String providerState;

  Proveedor({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });

  factory Proveedor.fromMap(Map<String, dynamic> map) {
    return Proveedor(
      providerId: map['providerid'],
      providerName: map['provider_name'],
      providerLastName: map['provider_last_name'],
      providerMail: map['provider_mail'],
      providerState: map['provider_state'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'providerid': providerId,
      'provider_name': providerName,
      'provider_last_name': providerLastName,
      'provider_mail': providerMail,
      'provider_state': providerState,
    };
  }
}
