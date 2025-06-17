class Article {
  final int id;
  final String libelle;
  final int qteStock;
  final double prixVente;

  Article({
    required this.id,
    required this.libelle,
    required this.qteStock,
    required this.prixVente,
  });

   factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      libelle: json['libelle'],
      qteStock: json['qteStock'],
      prixVente: (json['prixVente'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'libelle': libelle,
        'qteStock': qteStock,
        'prixVente': prixVente,
      };
}