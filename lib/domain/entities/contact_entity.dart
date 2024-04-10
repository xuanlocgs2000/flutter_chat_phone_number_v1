class ContactEntity {
  final String phoneNumber;
  String? label;
  String? uid;
  String? status;

  ContactEntity({
    required this.phoneNumber,
    this.label,
    this.uid,
    this.status,
  });
}
