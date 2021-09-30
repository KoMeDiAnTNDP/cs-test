class APIResponse<T> {
  final bool isOk;
  final String message;
  final T result;
  final int status;

  APIResponse({ this.isOk, this.message, this.result, this.status });
}

Map<String, String> createAuthorizedJsonHeaders(String token) {
  return { 'Accept': 'application/json', 'content-type': 'application/json', 'Authorization': 'Bearer $token' };
}

Map<String, String> createJsonHeaders() {
  return { 'Accept': 'application/json', 'content-type': 'application/json'};
}