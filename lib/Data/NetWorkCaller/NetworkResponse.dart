class NetworkResponse {
  bool isSuccess;
  Map<String, dynamic>? jsonResponse;
  int? statusCode;
  String? eRRor;

  NetworkResponse(
      {required this.isSuccess,
      this.jsonResponse,
      this.statusCode,
      this.eRRor='Unconditional Error'});
}
