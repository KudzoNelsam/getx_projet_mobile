import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_ligne_service.dart';
import 'package:default_projec/app/services/impl/simple_api_service.dart';

class LigneService extends SimpleApiService implements ILigneService{
  LigneService(super.baseUrl);

  @override
  Future<RestReponseModel> createLigne(Map<String, dynamic> body) {
    return createData("lignes", body);
  }

  @override
  Future<RestReponseModel> deleteLigne(String id) {
    return deleteData("lignes", id);
  }

  @override
  Future<RestReponseModel> getAllLignes({String? detteId}) {
    String endpoint = "lignes";
    if (detteId != null) {
      endpoint += "?detteId=$detteId";
    }
    return getData(endpoint);
  }

  @override
  Future<RestReponseModel> getLigneById(String id) {
    return getDataById("lignes", id);
  }

  @override
  Future<RestReponseModel> searchLignes(Map<String, dynamic> query) {
    String endpoint = "lignes/search";
    if (query.isNotEmpty) {
      endpoint += "?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}";
    }
    return getData(endpoint);
  }

  @override
  Future<RestReponseModel> updateLigne(String id, Map<String, dynamic> body) {
    return updateData("lignes", id, body);
  }
  
  @override
  Future<RestReponseModel> getLignesByDetteId(String detteId) {
    return getData("lignes?detteId=$detteId");
  }
  

  
}