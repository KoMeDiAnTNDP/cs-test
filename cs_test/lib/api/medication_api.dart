import 'dart:async';
import 'package:cs_test/api/api_utils.dart';
import 'package:cs_test/models/models.dart';
import 'package:cs_test/providers/providers.dart' show MedicationAPIProvider;
import 'dart:convert' show json;

class MedicationAPI {
  final MedicationAPIProvider _apiProvider;
  MedicationAPI(this._apiProvider);

  Future<APIResponse<List<Medication>>> getAll(String token) async {
    var response;
    try {
      response = await _apiProvider.getAll(token);
    } catch (exception) {
      if (exception is TimeoutException) return APIResponse<List<Medication>>(isOk: false, result: null, status: 408, message: 'Request timeout');
      else return APIResponse<List<Medication>>(isOk: false, result: null, status: 500, message: exception.toString());
    }

    if (response.statusCode != 200) {
      return APIResponse<List<Medication>>(isOk: false, message: response.body, result: null, status: response.statusCode);
    }
    List<Medication> medications = List<Medication>();
    try {
      dynamic responseBody = json.decode(response.body);
      if (responseBody != null) {
        for(Map medicationDto in responseBody) {
          medications.add(Medication.fromJson(medicationDto));
        }
      } else {
        throw Exception('Unexpected response body: ${response.body}');
      }
    } catch (exception) {
      print(exception);
      return APIResponse<List<Medication>>(isOk: false, message: exception.toString(), result: null, status: response.statusCode);
    }

    return APIResponse<List<Medication>>(isOk: true, message: 'OK', result: medications, status: response.statusCode);
  }
}