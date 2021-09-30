import 'package:cs_test/api/apis.dart';
import 'package:cs_test/middleware/middleware.dart';
import 'package:cs_test/pages/login/login_page.dart';
import 'package:cs_test/providers/auth_provider.dart';
import 'package:cs_test/providers/providers.dart';
import 'package:cs_test/routes.dart';
import 'package:cs_test/theme.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:cs_test/state.dart';
import 'package:cs_test/reducers/reducers.dart';


final AuthAPI authAPI = AuthAPI(AuthAPIProvider());
final UserAPI userAPI = UserAPI(UserAPIProvider());
final MedicationAPI medicationAPI = MedicationAPI(MedicationAPIProvider());

final GlobalKey<NavigatorState> navigatorStateKey = new GlobalKey<NavigatorState>();
void main() {
  var globalAppStateMiddleware = buildGlobalAppStateMiddleware(
    authAPI: authAPI,
    userAPI: userAPI,
    medicationAPI: medicationAPI,
    navigatorState: navigatorStateKey
  );

  final Store<GlobalAppState> store = Store<GlobalAppState>(
    globalAppStateReducer,
    initialState: GlobalAppState.initialState(),
    middleware: globalAppStateMiddleware
  );

  runApp(RappidTestApp(store));
}

class RappidTestApp extends StatelessWidget {
  final Store<GlobalAppState> store;
  RappidTestApp(this.store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<GlobalAppState>(
      store: store,
      child: MaterialApp(
        title: 'Chronically Simple',
        theme: buildTheme(context),
        navigatorKey: navigatorStateKey,
        routes: Routes.buildRoutes(store),
        home: StoreBuilder<GlobalAppState>(
          builder: (BuildContext context, Store<GlobalAppState> store) => LoginPage(),
        )
      )
    );
  }
}
