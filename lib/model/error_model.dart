class ErrorModel {
  String? cod;
  String? message;

  ErrorModel({this.cod, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cod'] = cod;
    data['message'] = message;
    return data;
  }
}
