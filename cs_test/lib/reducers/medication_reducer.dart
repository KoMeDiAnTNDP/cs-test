import 'package:redux/redux.dart';

import 'package:cs_test/models/models.dart';
import 'package:cs_test/actions/actions.dart';

Reducer<List<Medication>> medicationsReducer = combineReducers<List<Medication>>([
  TypedReducer<List<Medication>, SetMedicationsAction>(_setMedicationsReducer),
]);

List<Medication> _setMedicationsReducer(List<Medication> medications, SetMedicationsAction action) {
  return action.values;
}