import 'package:default_projec/app/modules/main_layout/views/main_layout_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dettes_detail_controller.dart';

class DettesDetailView extends GetView<DettesDetailController> {
  const DettesDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        title: const Text('Détail de la dette'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.dette.isEmpty) {
          return const Center(
            child: Text('Aucune dette trouvée', style: TextStyle(fontSize: 16)),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetteHeader(),
              const SizedBox(height: 20),
              _buildProgressSection(),
              const SizedBox(height: 20),
              _buildArticlesSection(),
              const SizedBox(height: 20),
              _buildPaiementsSection(),
              const SizedBox(height: 20),
              if (!controller.isDettePayee) _buildPaiementForm(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetteHeader() {
    final client = controller.client;
    final dette = controller.dette;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Client: ${client['nom'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Téléphone: ${client['telephone'] ?? 'N/A'}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Adresse: ${client['adresse'] ?? 'N/A'}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${dette['date'] ?? 'N/A'}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: controller.isDettePayee ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    controller.isDettePayee ? 'PAYÉE' : 'EN COURS',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    final dette = controller.dette;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progression du paiement',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: controller.pourcentagePaye / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                controller.isDettePayee ? Colors.green : Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Montant total', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    Text(
                      '${double.tryParse('${dette['montantDette']}')?.toStringAsFixed(2) ?? '0'} CFA',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Payé', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    Text(
                      '${double.tryParse('${dette['montantPaye']}')?.toStringAsFixed(2) ?? '0'} CFA',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Restant', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    Text(
                      '${controller.montantRestant.toStringAsFixed(2)} CFA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.isDettePayee ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticlesSection() {
  final lignes = controller.lignes;
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Articles achetés',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (lignes.isEmpty)
            const Text('Aucun article trouvé')
          else
            Column(
              children: lignes.map((ligne) {
                // CORRECTION: Utilisation sécurisée de getArticleById
                final article = controller.getArticleById(ligne['articleId']);
                final prixUnitaire = double.tryParse(article['prixVente']?.toString() ?? '0') ?? 0.0;
                final quantite = int.tryParse(ligne['qteCom']?.toString() ?? '0') ?? 0;
                final sousTotal = prixUnitaire * quantite;
                
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article['libelle'] ?? 'Article #${ligne['articleId']}',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Prix unitaire: ${prixUnitaire.toStringAsFixed(2)} CFA',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Qté: $quantite', 
                            style: const TextStyle(fontWeight: FontWeight.w500)
                          ),
                          Text(
                            'Sous-total: ${sousTotal.toStringAsFixed(2)} CFA',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    ),
  );
}

  Widget _buildPaiementsSection() {
    final paiements = controller.paiements;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Historique des paiements',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (paiements.isEmpty)
              const Text('Aucun paiement effectué')
            else
              Column(
                children: paiements.map((paiement) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              paiement['date'] ?? 'N/A',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Paiement #${paiement['id']}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          '${double.tryParse('${paiement['montantVerse']}')?.toStringAsFixed(2) ?? '0'} CFA',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaiementForm() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nouveau paiement',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.paiementController,
                decoration: InputDecoration(
                  labelText: 'Montant à payer',
                  suffixText: 'CFA',
                  border: const OutlineInputBorder(),
                  hintText: 'Max: ${controller.montantRestant.toStringAsFixed(2)} CFA',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Veuillez saisir un montant';
                  final montant = double.tryParse(value);
                  if (montant == null || montant <= 0) return 'Montant invalide';
                  if (montant > controller.montantRestant) return 'Montant supérieur au restant dû';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.isLoadingPaiement.value
                      ? null
                      : controller.enregistrerPaiement,
                  icon: controller.isLoadingPaiement.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.payment),
                  label: const Text('Enregistrer le paiement'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
