class PostModel {
  bool status;
  String message;

  PostModel({
    required this.status,
    required this.message,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      status: json['status'] as bool,
      message: json['message'] as String,
    );
  }
}
