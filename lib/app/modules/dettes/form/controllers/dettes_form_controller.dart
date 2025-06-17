import 'package:default_projec/app/services/impl/article_service.dart';
import 'package:default_projec/app/services/impl/client_service.dart';
import 'package:default_projec/app/services/impl/dette_service.dart';
import 'package:default_projec/app/services/impl/ligne_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DettesFormController extends GetxController {
  final ClientService clientService = Get.find();
  final ArticleService articleService = Get.find();
  final DetteService detteService = Get.find();
  final LigneService ligneService = Get.find();

  var clients = [].obs;
  var articles = [].obs;

  var selectedClientId = Rxn<String>();
  var selectedArticleId = Rxn<String>();
  var qteText = ''.obs;

  final qteController = TextEditingController();

  var panier = <Map<String, dynamic>>[].obs; // [{articleId, qte}]
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchClients();
    fetchArticles();
    final args = Get.arguments;
    if (args != null && args['clientId'] != null) {
      selectedClientId.value = args['clientId'];
    }
    // Pour réactiviter bouton dynamiquement
    qteController.addListener(() {
      qteText.value = qteController.text;
    });
  }

  Future<void> fetchClients() async {
    final response = await clientService.getClients();
    if (response.statusCode == 200) {
      clients.value = response.data;
    }
  }

  Future<void> fetchArticles() async {
    final response = await articleService.getAllArticles();
    if (response.statusCode == 200) {
      articles.value = response.data;
    }
  }

  // Si on change de client, on vide le panier
  void onChangeClient(String? value) {
    selectedClientId.value = value;
    panier.clear();
    // On reset aussi la sélection d'article et de quantité
    selectedArticleId.value = null;
    qteController.clear();
  }

  bool get canAddToPanier {
    if (selectedArticleId.value == null) return false;
    final qte = int.tryParse(qteText.value) ?? 0;
    final article = articles.firstWhereOrNull((a) => a['id'] == selectedArticleId.value);
    if (article == null) return false;
    if (qte <= 0) return false;
    
    // Vérifier la quantité totale (existante dans le panier + nouvelle quantité)
    final existingItem = panier.firstWhereOrNull((e) => e['articleId'] == selectedArticleId.value);
    final existingQte = existingItem?['qte'] ?? 0;
    final totalQte = existingQte + qte;
    
    if (totalQte > article['qteStock']) return false;
    
    return true;
  }

  void addToPanier() {
    final articleId = selectedArticleId.value;
    final qte = int.tryParse(qteText.value) ?? 0;
    
    if (articleId != null && qte > 0) {
      // Vérifier si l'article existe déjà dans le panier
      final existingItemIndex = panier.indexWhere((item) => item['articleId'] == articleId);
      
      if (existingItemIndex != -1) {
        // L'article existe déjà, on augmente la quantité
        final currentQte = panier[existingItemIndex]['qte'] as int;
        panier[existingItemIndex] = {
          'articleId': articleId,
          'qte': currentQte + qte,
        };
        Get.snackbar(
          "Article mis à jour", 
          "Quantité augmentée dans le panier",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        // Nouvel article, on l'ajoute au panier
        panier.add({'articleId': articleId, 'qte': qte});
        Get.snackbar(
          "Article ajouté", 
          "Article ajouté au panier",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
      
      // Reset les champs
      selectedArticleId.value = null;
      qteController.clear();
    }
  }

  void removeFromPanier(int articleId) {
    panier.removeWhere((item) => item['articleId'] == articleId);
  }

  // Nouvelle méthode pour modifier directement la quantité dans le panier
  void updateQuantityInPanier(int articleId, int newQte) {
    final article = articles.firstWhereOrNull((a) => a['id'] == articleId);
    if (article == null) return;
    
    if (newQte <= 0) {
      removeFromPanier(articleId);
      return;
    }
    
    if (newQte > article['qteStock']) {
      Get.snackbar("Erreur", "Stock insuffisant (${article['qteStock']} disponible)");
      return;
    }
    
    final itemIndex = panier.indexWhere((item) => item['articleId'] == articleId);
    if (itemIndex != -1) {
      panier[itemIndex] = {'articleId': articleId, 'qte': newQte};
    }
  }

  double get panierTotal {
    double t = 0;
    for (final item in panier) {
      final article = articles.firstWhereOrNull((a) => a['id'] == item['articleId']);
      if (article != null) {
        t += (article['prixVente'] ?? 0) * (item['qte'] ?? 0);
      }
    }
    return t;
  }

  Future<void> submit() async {
    if (selectedClientId.value == null || panier.isEmpty) {
      Get.snackbar("Erreur", "Sélectionnez un client et ajoutez au moins un article au panier.");
      return;
    }
    isLoading.value = true;
    try {
      final detteRes = await detteService.createDette({
        'date': DateTime.now().toIso8601String().split('T').first,
        'montantDette': panierTotal,
        'montantPaye': 0,
        'montantRestant': panierTotal,
        'clientId': selectedClientId.value,
      });
      if (detteRes.statusCode == 201) {
        final detteId = detteRes.data['id'];
        for (final item in panier) {
          await ligneService.createLigne({
            'qteCom': item['qte'],
            'articleId': item['articleId'],
            'detteId': detteId,
          });
        }
        Get.back(result: true);
        Get.snackbar("Succès", "Dette et achats enregistrés !");
      } else {
        Get.snackbar("Erreur", "Impossible de créer la dette.");
      }
    } catch (e) {
      Get.snackbar("Erreur", "Une erreur est survenue.");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    qteController.dispose();
    super.onClose();
  }
}