class RestReponseModel {
  final int statusCode;
  final String message;
  final dynamic data;

  RestReponseModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory RestReponseModel.fromJson(Map<String, dynamic> json) {
    return RestReponseModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}