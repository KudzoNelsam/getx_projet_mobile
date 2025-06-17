class Ligne {
  final int id;
  final int qteCom;
  final int articleId; // ForeignKey Article
  final int detteId;   // ForeignKey Dette

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