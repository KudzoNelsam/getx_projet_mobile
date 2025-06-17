import 'package:default_projec/app/modules/main_layout/views/main_layout_view.dart';
import 'package:default_projec/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/clients_list_controller.dart';

class ClientsListView extends GetView<ClientsListController> {
  const ClientsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      appBar: AppBar(
        title: const Text('Liste des clients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.onSearch,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CLIENTS_FORM),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Rechercher par nom',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: controller.onSearch,
                ),
              ),
              onSubmitted: (_) => controller.onSearch(),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.clients.isEmpty) {
                return const Center(child: Text('Aucun client'));
              }
              return ListView.builder(
                itemCount: controller.clients.length,
                itemBuilder: (context, i) {
                  final c = controller.clients[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        child: Text(
                          (c['nom']?.isNotEmpty == true
                              ? c['nom'][0].toUpperCase()
                              : '?'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        c['nom'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (c['telephone'] != null &&
                              c['telephone'].toString().isNotEmpty)
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(c['telephone']),
                              ],
                            ),
                          if (c['adresse'] != null &&
                              c['adresse'].toString().isNotEmpty)
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Flexible(child: Text(c['adresse'])),
                              ],
                            ),
                        ],
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          Get.toNamed('/dettes/list', arguments: c['id']),
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
