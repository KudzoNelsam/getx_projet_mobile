class Ligne {
  final String id;
  final int qteCom;
  final String articleId; // ForeignKey Article
  final String detteId;   // ForeignKey Dette

  Ligne({
    required this.id,
    required this.qteCom,
    required this.articleId,
    required this.detteId,
  });

  
   factory Ligne.fromJson(Map<String, dynamic> json) {
    return Ligne(
      id: json['id'],
      qteCom: json['qteCom'],
      articleId: json['articleId'],
      detteId: json['detteId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'qteCom': qteCom,
        'articleId': articleId,
        'detteId': detteId,
      };
}