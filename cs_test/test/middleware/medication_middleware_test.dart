import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/api/apis.dart';
import 'package:cs_test/models/models.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';



void main() {
  group("Medication Middleware", () {
    test("should successfully load Medications ", () async {
      var api = MockMedicationApi();
      var store = buildStore(api);

      when(api.getAll(any)).thenAnswer((_) => Future.value(APIResponse(isOk: true, result: [Medication.createEmpty(), Medication.createEmpty()])));

      expect(store.state.apiStateRepository.medicationState.loadingStatus, LoadingStatus.idle);
      expect(store.state.dataStateRepository.medications.length, 0);

      store.dispatch(RequestGetMedicationsAction());

      verify(api.getAll(any)).called(1);
      expect(store.state.apiStateRepository.medicationState.loadingStatus, LoadingStatus.loading);

      await new Future.delayed(new Duration(milliseconds: 50));

      expect(store.state.apiStateRepository.medicationState.loadingStatus, LoadingStatus.success);
      expect(store.state.dataStateRepository.medications.length, 2);
    });

    test("should fail load Medications ", () async {
      var api = MockMedicationApi();
      var store = buildStore(api);

      when(api.getAll(any)).thenAnswer((_) => Future.value(APIResponse(isOk: false, result: null, status: 408, message: 'Request timeout')));

      expect(store.state.apiStateRepository.medicationState.loadingStatus, LoadingStatus.idle);
      expect(store.state.dataStateRepository.medications.length, 0);

      store.dispatch(RequestGetMedicationsAction());

      verify(api.getAll(any)).called(1);
      expect(store.state.apiStateRepository.medicationState.loadingStatus, LoadingStatus.loading);

      await new Future.delayed(new Duration(milliseconds: 50));

      expect(store.state.apiStateRepository.medicationState.loadingStatus, LoadingStatus.failed);
      expect(store.state.dataStateRepository.medications.length, 0);
    });
  });
}
