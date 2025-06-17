import 'package:default_projec/app/data/rest_reponse_model.dart';
import 'package:default_projec/app/services/i_article_service.dart';
import 'package:default_projec/app/services/impl/simple_api_service.dart';

class ArticleService extends SimpleApiService implements IArticleService{
  ArticleService(super.baseUrl);
  
  @override
  Future<RestReponseModel> createArticle(Map<String, dynamic> body) {
    return createData("articles", body);
  }
  
  @override
  Future<RestReponseModel> deleteArticle(int id) {
    return deleteData("articles", id);
  }
  
  @override
  Future<RestReponseModel> getAllArticles({int? clientId}) {
    String endpoint = "articles";
    if (clientId != null) {
      endpoint += "?clientId=$clientId";
    }
    return getData(endpoint);
  }
  
  @override
  Future<RestReponseModel> getArticleById(int id) {
    return getDataById("articles", id);
  }
  
  @override
  Future<RestReponseModel> searchArticles(Map<String, dynamic> query) {
    String endpoint = "articles/search";
    if (query.isNotEmpty) {
      endpoint += "?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}";
    }
    return getData(endpoint);
  }
  
  @override
  Future<RestReponseModel> updateArticle(int id, Map<String, dynamic> body) {
    return updateData("articles", id, body);
  }

  
  

  
}