class ProveedorEdit {
  final int providerId;
  final String providerName;
  final String providerLastName;
  final String providerMail;
  final String providerState;

  ProveedorEdit({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerMail,
    required this.providerState,
  });

  factory ProveedorEdit.fromMap(Map<String, dynamic> map) {
    return ProveedorEdit(
      providerId: map['provider_id'],
      providerName: map['provider_name'],
      providerLastName: map['provider_last_name'],
      providerMail: map['provider_mail'],
      providerState: map['provider_state'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'provider_id': providerId,
      'provider_name': providerName,
      'provider_last_name': providerLastName,
      'provider_mail': providerMail,
      'provider_state': providerState,
    };
  }
}
