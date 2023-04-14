class BookingList {
  final String driverID;
  final String userID;
  final String from;
  final String to;
  final bool status;

  BookingList({
    required this.driverID,
    required this.userID,
    required this.from,
    required this.to,
    required this.status,
  });

  factory BookingList.fromJson(Map<String, dynamic> snapshot) {
    return BookingList(
        driverID: snapshot['driverID'],
        userID: snapshot['userID'],
        from: snapshot['from'],
        to: snapshot['to'],
        status: snapshot['status']);
  }
}
