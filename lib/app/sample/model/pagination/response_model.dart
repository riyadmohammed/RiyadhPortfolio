class ResponseModel {
  dynamic result;
  dynamic data;
  dynamic error;

  ResponseModel({this.result, this.data, this.error});

  ResponseModel copyWith({
    dynamic result,
    dynamic data,
    dynamic error,
  }) =>
      ResponseModel(result: result ?? this.result, data: data ?? this.data, error: error ?? this.error);

  ResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() => {'result': result, 'data': data, 'error': error};
}
