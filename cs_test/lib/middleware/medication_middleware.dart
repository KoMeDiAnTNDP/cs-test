import 'package:redux/redux.dart';

import 'package:cs_test/api/apis.dart';

import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/models/models.dart';
import 'package:cs_test/state.dart';

Middleware<GlobalAppState> buildHandleGetMedications(MedicationAPI medicationAPI) {
  return (Store<GlobalAppState> store, action, NextDispatcher next) async {
    if (store.state.apiStateRepository.medicationState.loadingStatus == LoadingStatus.loading) return;
    store.dispatch(MedicationAPIStateAction(status: LoadingStatus.loading, code: 0, message: '' ));
    APIResponse<List<Medication>> fetchMedicationsResponse = await medicationAPI.getAll(store.state.authStateRepository.authToken);
    if (fetchMedicationsResponse.isOk) {
      store.dispatch(MedicationAPIStateAction(
          status: LoadingStatus.success, code: 200, message: 'OK'));
      store.dispatch(SetMedicationsAction(fetchMedicationsResponse.result));
    } else {
      store.dispatch(MedicationAPIStateAction(
          status: LoadingStatus.failed, code: fetchMedicationsResponse.status, message: fetchMedicationsResponse.message));
    }
  };
}