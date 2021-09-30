import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/models/data_state.dart';
import 'package:cs_test/models/medication_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/state.dart';

class MedicationViewModel {
  final DataStateRepository dataState;
  final Function getAll;

  MedicationViewModel({
    @required this.dataState,
    @required this.getAll
  });

  List<Medication> get activeMedications {
    var now = new DateTime.now().toUtc();
    return this.dataState.medications.where((m) => m.start.toUtc().isBefore(now) && m.expiry.toUtc().isAfter(now)).toList();
  }

  List<Medication> get expiredMedications {
    var now = new DateTime.now().toUtc();
    var result = this.dataState.medications
        .where((m) => m.expiry.toUtc().isBefore(now)).toList();
    result.sort((first, second) => first.timeIntervals[0].compareTo(second.timeIntervals[0]));
    return result;
  }

  List<Medication> get todayMedications {
    var now = new DateTime.now();
    var result = this.activeMedications.where((m) {
      var shouldInclude = false;
      var timesToTake = m.timeIntervals;
      for (var time in timesToTake) {
        shouldInclude = now.isBefore(time);
      }
      return shouldInclude;
    }).toList();
    result.sort((first, second) => first.closestTimeIntervalToNow.compareTo(second.closestTimeIntervalToNow));
    return result;
  }

  @override
  int get hashCode => dataState.hashCode;

  @override
  operator ==(Object other) =>
      identical(this, other) ||
          other is MedicationViewModel &&
              other.dataState == dataState;

  factory MedicationViewModel.create(Store<GlobalAppState> store) =>
      MedicationViewModel(dataState: store.state.dataStateRepository, getAll: () => store.dispatch(RequestGetMedicationsAction()));
}
