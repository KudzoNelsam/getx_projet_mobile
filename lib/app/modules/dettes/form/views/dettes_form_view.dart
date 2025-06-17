import 'package:default_projec/app/modules/main_layout/views/main_layout_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dettes_form_controller.dart';

class DettesFormView extends GetView<DettesFormController> {
  const DettesFormView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        title: const Text('Nouvelle dette'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            // Sélection client
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedClientId.value,
              decoration: const InputDecoration(
                labelText: "Client",
                border: OutlineInputBorder(),
              ),
              items: controller.clients
                  .map<DropdownMenuItem<String>>(
                    (c) => DropdownMenuItem<String>(
                      value: c['id'],
                      child: Text(c['nom']),
                    ),
                  )
                  .toList(),
              onChanged: (v) => controller.onChangeClient(v),
              validator: (v) => v == null ? "Sélectionnez un client" : null,
            )),
            const SizedBox(height: 24),

            // Sélection d'un article
            const Text(
              "Ajouter un article au panier :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedArticleId.value,
              decoration: const InputDecoration(
                labelText: "Article",
                border: OutlineInputBorder(),
              ),
              items: controller.articles
                  .map<DropdownMenuItem<String>>(
                    (a) => DropdownMenuItem<String>(
                      value: a['id'],
                      child: Text("${a['libelle']} (Stock: ${a['qteStock']})"),
                    ),
                  )
                  .toList(),
              onChanged: (v) => controller.selectedArticleId.value = v,
              validator: (_) => null,
            )),
            const SizedBox(height: 12),

            // Saisie de la quantité
            TextFormField(
              controller: controller.qteController,
              decoration: const InputDecoration(
                labelText: "Quantité",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => controller.qteText.value = val,
              validator: (txt) {
                if (controller.selectedArticleId.value == null) return null;
                final qte = int.tryParse(txt ?? '') ?? 0;
                final selectedArticle = controller.articles
                    .firstWhereOrNull((a) => a['id'] == controller.selectedArticleId.value);
                if (selectedArticle == null) return null;
                if (qte <= 0) return "Quantité invalide";
                
                // Vérifier la quantité totale (existante + nouvelle)
                final existingItem = controller.panier.firstWhereOrNull(
                  (e) => e['articleId'] == controller.selectedArticleId.value
                );
                final existingQte = existingItem?['qte'] ?? 0;
                final totalQte = existingQte + qte;
                
                if (totalQte > selectedArticle['qteStock']) {
                  return "Stock insuffisant (${selectedArticle['qteStock']} dispo, ${existingQte} déjà dans le panier)";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Bouton Ajouter au panier
            Obx(() => ElevatedButton.icon(
              onPressed: controller.canAddToPanier
                  ? () => controller.addToPanier()
                  : null,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Ajouter au panier"),
            )),
            const SizedBox(height: 28),

            // Affichage du panier
            Obx(() {
              if (controller.panier.isEmpty) {
                return const Text(
                  "Aucun article dans le panier.",
                  style: TextStyle(fontStyle: FontStyle.italic),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Panier :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text("Article")),
                      DataColumn(label: Text("Prix")),
                      DataColumn(label: Text("Quantité")),
                      DataColumn(label: Text("Sous-total")),
                      DataColumn(label: Text("")),
                    ],
                    rows: controller.panier.map((item) {
                      final article = controller.articles.firstWhereOrNull(
                        (a) => a['id'] == item['articleId']
                      );
                      return DataRow(cells: [
                        DataCell(Text(article?['libelle'] ?? '')),
                        DataCell(Text('${article?['prixVente'] ?? ""} CFA')),
                        // Affichage simple de la quantité (réactif)
                        DataCell(Text('${item['qte']}')),
                        DataCell(Text('${((article?['prixVente'] ?? 0) * item['qte']).toStringAsFixed(2)} CFA')),
                        // Seulement le bouton supprimer
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: "Retirer du panier",
                            onPressed: () => controller.removeFromPanier(item['articleId']),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total : ${controller.panierTotal.toStringAsFixed(2)} CFA",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 18, 
                          color: Colors.green
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            const SizedBox(height: 28),

            // Bouton valider la dette
            Obx(() => ElevatedButton.icon(
              onPressed: controller.isLoading.value ? null : controller.submit,
              icon: controller.isLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2, 
                        color: Colors.white
                      ),
                    )
                  : const Icon(Icons.save),
              label: const Text("Valider la dette"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                textStyle: const TextStyle(fontSize: 16),
              ),
            )),
          ],
        ),
      ),
    );
  }
}