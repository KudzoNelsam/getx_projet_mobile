import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_paiement_service.dart';
import 'package:default_projec/app/services/impl/simple_api_service.dart';

class PaiementService extends SimpleApiService implements IPaiementService{
  PaiementService(super.baseUrl);
  
  @override
  Future<RestReponseModel> createPaiement(Map<String, dynamic> body) {
    return createData("paiements", body);
  }
  
  @override
  Future<RestReponseModel> deletePaiement(String id) {
    return deleteData("paiements", id);
  }
  
  @override
  Future<RestReponseModel> getAllPaiements({String? clientId}) {
    String endpoint = "paiements";
    if (clientId != null) {
      endpoint += "?clientId=$clientId";
    }
    return getData(endpoint);
  }
  
  @override
  Future<RestReponseModel> getPaiementById(String id) {
    return getDataById("paiements", id);
  }
  
  @override
  Future<RestReponseModel> getPaiementsByClientId(String clientId) {
    return getData("paiements?clientId=$clientId");
  }
  
  @override
  Future<RestReponseModel> getPaiementsByDetteId(String detteId) {
    return getData("paiements?detteId=$detteId");
  }
  
  @override
  Future<RestReponseModel> getPaiementsByLigneId(String ligneId) {
    return getData("paiements?ligneId=$ligneId");
  }
  
  @override
  Future<RestReponseModel> searchPaiements(Map<String, dynamic> query) {
    String endpoint = "paiements/search";
    if (query.isNotEmpty) {
      endpoint += "?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}";
    }
    return getData(endpoint);
  }
  
  @override
  Future<RestReponseModel> updatePaiement(String id, Map<String, dynamic> body) {
    return updateData("paiements", id, body);
  }

 

  
}