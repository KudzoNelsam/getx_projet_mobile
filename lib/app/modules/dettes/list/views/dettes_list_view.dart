import 'package:default_projec/app/modules/main_layout/views/main_layout_view.dart';
import 'package:default_projec/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dettes_list_controller.dart';

class DettesListView extends GetView<DettesListController> {
  const DettesListView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.DETTES_FORM),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Liste de toutes les dettes'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchDettes,
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButtonFormField<int>(
                value: controller.selectedClientId.value,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: "Filtrer par client",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                items: [
                  const DropdownMenuItem<int>(
                    value: null,
                    child: Text("Tous les clients"),
                  ),
                  ...controller.clients.map<DropdownMenuItem<int>>(
                    (c) => DropdownMenuItem<int>(
                      value: c['id'],
                      child: Text(c['nom']),
                    ),
                  ),
                ],
                onChanged: controller.filterByClient,
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.dettes.isEmpty) {
                return const Center(child: Text('Aucune dette trouvée'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: controller.dettes.length,
                itemBuilder: (context, i) {
                  final d = controller.dettes[i];
                  final montantRestant = d['montantRestant'] ?? 0;
                  final isPaid = montantRestant <= 0;
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: isPaid
                            ? Colors.green
                            : Colors.redAccent,
                        child: Icon(
                          isPaid ? Icons.check : Icons.warning,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        d['description'] ?? 'Dette',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (d['client'] != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  d['client']['nom'] ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          Text(
                            'Montant total : ${d['montantDette']} €',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Montant restant : $montantRestant €',
                            style: TextStyle(
                              fontSize: 14,
                              color: isPaid ? Colors.green : Colors.orange,
                            ),
                          ),
                          Text(
                            'Date : ${d['date']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          Get.toNamed(Routes.DETTES_LIST, arguments: d['id']),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
