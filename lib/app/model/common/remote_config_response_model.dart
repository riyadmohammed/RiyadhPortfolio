class RemoteConfigResponseModel {
  final String lang;
  final String message;

  RemoteConfigResponseModel({
    required this.lang,
    required this.message,
  });

  factory RemoteConfigResponseModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigResponseModel(
      lang: json['lang'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lang': lang,
      'message': message,
    };
  }

  RemoteConfigResponseModel copyWith({
    String? lang,
    String? message,
  }) {
    return RemoteConfigResponseModel(
      lang: lang ?? this.lang,
      message: message ?? this.message,
    );
  }
}
