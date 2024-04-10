class ContactEntity {
  final String phoneNumber;
  final String label;
  String? uid;
  String? status;

  ContactEntity({
    required this.phoneNumber,
    required this.label,
    this.uid,
    this.status,
  });
}
