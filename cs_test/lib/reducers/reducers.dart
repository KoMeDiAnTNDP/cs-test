import 'package:cs_test/reducers/auth_reducer.dart';
import 'package:cs_test/reducers/data_state_reducer.dart';
import 'package:cs_test/reducers/loading_reducer.dart';
import 'package:cs_test/reducers/navigation_reducer.dart';
import 'package:cs_test/state.dart';

GlobalAppState globalAppStateReducer(GlobalAppState state, action) => GlobalAppState(
  apiStateRepository: apiStateReducer(state.apiStateRepository, action),
  authStateRepository: authStateReducer(state.authStateRepository, action),
  navigationStateRepository: navigationStateReducer(state.navigationStateRepository, action),
  dataStateRepository: dataStateReducer(state.dataStateRepository, action),
);