import 'package:cs_test/api/api_utils.dart';
import 'package:cs_test/config/config.dart' as config;
import 'package:http/http.dart' as http;

class UserAPIProvider {
    final String url = '${config.getAPIUrl()}/users/me';

    Future<http.Response> getWithToken(token) {
      return http.get(Uri.encodeFull(url), headers: createAuthorizedJsonHeaders(token)).timeout(Duration(seconds: 5));
    }
}
