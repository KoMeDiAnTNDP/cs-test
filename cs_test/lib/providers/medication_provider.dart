import 'package:http/http.dart' as http;
import 'package:cs_test/api/api_utils.dart';
import 'package:cs_test/config/config.dart' as config;

class MedicationAPIProvider {
  final String _supportTeamBaseUrl = '${config.getAPIUrl()}/prescriptions';

  Future<http.Response> getAll(String token) {
    return http.get(
      Uri.encodeFull(_supportTeamBaseUrl), 
      headers: createAuthorizedJsonHeaders(token)
    );
  }
}