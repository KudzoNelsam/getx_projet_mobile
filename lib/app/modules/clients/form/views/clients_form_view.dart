import 'package:default_projec/app/modules/main_layout/views/main_layout_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/clients_form_controller.dart';

class ClientsFormView extends GetView<ClientsFormController> {
  const ClientsFormView({super.key});
  @override
  Widget build(BuildContext context) {
   return MainLayoutView(
      appBar: AppBar(
        title: Text(controller.clientId == null ? 'Ajouter un client' : 'Modifier le client'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.nomController,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Nom obligatoire' : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.telephoneController,
                  decoration: const InputDecoration(
                    labelText: 'Téléphone',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.adresseController,
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton.icon(
                      onPressed: controller.isLoading.value ? null : controller.submit,
                      icon: controller.isLoading.value
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.save),
                      label: Text(controller.clientId == null ? 'Ajouter' : 'Modifier'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
