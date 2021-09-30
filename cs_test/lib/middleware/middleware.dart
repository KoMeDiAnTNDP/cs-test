import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/state.dart';
import 'package:cs_test/api/apis.dart';
import 'package:cs_test/actions/actions.dart';

import 'package:cs_test/main.dart';

import 'package:cs_test/middleware/auth_middleware.dart' as Auth;
import 'package:cs_test/middleware/medication_middleware.dart' as Medication;
import 'package:cs_test/middleware/navigation_middleware.dart' as Navigation;

List<Middleware<GlobalAppState>> buildGlobalAppStateMiddleware({
  @required AuthAPI authAPI,
  @required UserAPI userAPI,
  @required MedicationAPI medicationAPI,
  @required GlobalKey<NavigatorState> navigatorState,
}) => [
    TypedMiddleware<GlobalAppState, NavigateRootAction>(Navigation.buildHandleNavigateRootAction(navigatorState)),

    TypedMiddleware<GlobalAppState, LogInAction>(Auth.buildHandleLogInMiddleware(authAPI, userAPI)),
    TypedMiddleware<GlobalAppState, LogOutAction>(Auth.buildHandleLogOutMiddleware(authAPI)),
    TypedMiddleware<GlobalAppState, LogInSuccessAction>(Auth.buildHandleLogInSuccessMiddleware(authAPI)),

    TypedMiddleware<GlobalAppState, RequestGetMedicationsAction>(Medication.buildHandleGetMedications(medicationAPI)),
];