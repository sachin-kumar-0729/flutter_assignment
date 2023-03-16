class ApiException {
  // Use something like "int code;" if you want to translate error messages
  final String message;
  final int? statusCode;

  ApiException({required this.message,this.statusCode});

  @override
  String toString() => message;
}