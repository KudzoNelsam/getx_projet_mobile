class Dette {
  final int id;
  final DateTime date;
  final double montantDette;
  final double montantPaye;
  final double montantRestant;
  final int clientId; // ForeignKey Client

  Dette({
    required this.id,
    required this.date,
    required this.montantDette,
    required this.montantPaye,
    required this.montantRestant,
    required this.clientId,
  });

    factory Dette.fromJson(Map<String, dynamic> json) {
    return Dette(
      id: json['id'],
      date: DateTime.parse(json['date']),
      montantDette: (json['montantDette'] as num).toDouble(),
      montantPaye: (json['montantPaye'] as num).toDouble(),
      montantRestant: (json['montantRestant'] as num).toDouble(),
      clientId: json['clientId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'montantDette': montantDette,
        'montantPaye': montantPaye,
        'montantRestant': montantRestant,
        'clientId': clientId,
      };
}