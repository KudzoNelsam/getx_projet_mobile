class Paiement {
  final String id;
  final DateTime date;
  final double montantVerse;
  final String clientId; // ForeignKey Client
  final String detteId;  // ForeignKey Dette

  Paiement({
    required this.id,
    required this.date,
    required this.montantVerse,
    required this.clientId,
    required this.detteId,
  });

    factory Paiement.fromJson(Map<String, dynamic> json) {
    return Paiement(
      id: json['id'],
      date: DateTime.parse(json['date']),
      montantVerse: (json['montantVerse'] as num).toDouble(),
      clientId: json['clientId'],
      detteId: json['detteId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'montantVerse': montantVerse,
        'clientId': clientId,
        'detteId': detteId,
      };
}