import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';

abstract class IPaiementService extends ISimpleApiService{
  Future<RestReponseModel> getAllPaiements({String? clientId});
  Future<RestReponseModel> getPaiementById(String id);
  Future<RestReponseModel> createPaiement(Map<String, dynamic> body);
  Future<RestReponseModel> updatePaiement(String id, Map<String, dynamic> body);
  Future<RestReponseModel> deletePaiement(String id);
  Future<RestReponseModel> searchPaiements(Map<String, dynamic> query);
  Future<RestReponseModel> getPaiementsByClientId(String clientId);
  Future<RestReponseModel> getPaiementsByDetteId(String detteId);
  Future<RestReponseModel> getPaiementsByLigneId(String ligneId);
}