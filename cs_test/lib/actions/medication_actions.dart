import 'package:cs_test/models/models.dart';

class RequestGetMedicationsAction {
  RequestGetMedicationsAction();
}

class SetMedicationsAction {
final List<Medication> values;
SetMedicationsAction(this.values);
}

class RequestUpdateMedicationAction {
  final Medication value;
  RequestUpdateMedicationAction(this.value);
}