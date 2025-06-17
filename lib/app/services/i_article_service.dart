import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_simple_api_service.dart';

abstract class IArticleService extends ISimpleApiService{
  Future<RestReponseModel> getAllArticles({String? clientId});
  Future<RestReponseModel> getArticleById(String id);
  Future<RestReponseModel> createArticle(Map<String, dynamic> body);
  Future<RestReponseModel> updateArticle(String id, Map<String, dynamic> body);
  Future<RestReponseModel> deleteArticle(String id);
  Future<RestReponseModel> searchArticles(Map<String, dynamic> query);
}