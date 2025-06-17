class Client {
  final int id;
  final String nom;
  final String telephone;
  final String adresse;

  Client({
    required this.id,
    required this.nom,
    required this.telephone,
    required this.adresse,
  });

    factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      nom: json['nom'],
      telephone: json['telephone'],
      adresse: json['adresse'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'telephone': telephone,
        'adresse': adresse,
      };
}