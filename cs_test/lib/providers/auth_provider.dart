import 'dart:convert' show json;
import 'package:http/http.dart' as http;

import 'package:cs_test/config/config.dart' as config;

class AuthAPIProvider {
  final String url = '${config.getAPIUrl()}/auth';
  AuthAPIProvider();

  Future<http.Response> loginPost(String email, String password) async {
      return http.post(
        Uri.encodeFull(url), headers: { 'Accept': 'application/json', 'content-type': 'application/json' }, body: json.encode({ 'email': email, 'password': password }))
          .timeout(Duration(seconds: 10));
  }
}
