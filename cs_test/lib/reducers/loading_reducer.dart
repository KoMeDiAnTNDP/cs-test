import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/models/models.dart';
import 'package:redux/redux.dart';

Reducer<APIStateRepository> apiStateReducer = combineReducers([
  TypedReducer<APIStateRepository, AuthAPIStateAction>(_authAPIStateReducer),
  TypedReducer<APIStateRepository, MedicationAPIStateAction>(_medicationAPIStateReducer),
]);

APIStateRepository _authAPIStateReducer(APIStateRepository repository, AuthAPIStateAction action) {
  return repository.copyWith(authState: APIState.fromAction(action));
}

APIStateRepository _medicationAPIStateReducer(APIStateRepository repository, MedicationAPIStateAction action) {
  return repository.copyWith(medicationState: APIState.fromAction(action));
}

