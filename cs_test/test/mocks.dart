import 'package:cs_test/api/apis.dart';
import 'package:cs_test/middleware/middleware.dart';
import 'package:cs_test/pages/pages.dart';
import 'package:cs_test/reducers/reducers.dart';
import 'package:cs_test/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class MockAuthApi extends Mock implements AuthAPI {}
class MockUserApi extends Mock implements UserAPI {}
class MockMedicationApi extends Mock implements MedicationAPI {}

Store<GlobalAppState> buildStore(MedicationAPI api) {
  final GlobalKey<NavigatorState> navigatorStateKey = new GlobalKey<NavigatorState>();
  var globalAppStateMiddleware = buildGlobalAppStateMiddleware(
      authAPI: MockAuthApi(),
      userAPI: MockUserApi(),
      medicationAPI: api,
      navigatorState: navigatorStateKey
  );
  final Store<GlobalAppState> store = Store<GlobalAppState>(
      globalAppStateReducer,
      initialState: GlobalAppState.initialState(),
      middleware: globalAppStateMiddleware
  );
  return store;
}

Widget makeWidgetToPump(api, vsync, initialIndex) {
  var store = buildStore(api);

  final tabController =
  TabController(initialIndex: initialIndex, length: 3, vsync: vsync);
  final widget = MedicationPage(tabController: tabController);
  final widgetToPump = StoreProvider(
      store: store,
      child: MaterialApp(
          title: 'Chronically Simple',
          home: StoreBuilder<GlobalAppState>(
            builder: (BuildContext context, Store<GlobalAppState> store) =>
            widget,
          )));
  return widgetToPump;
}

const expiredMedications = '''[{
        "id": 1,
        "name": "Hydrochlorathiazide",
        "dosage": "12.5",
        "dosageType": "mg",
        "dosageSize": null,
        "timesPerDay": 2,
        "start": "2000-01-31T19:00:00.000Z",
        "expiry": "2000-04-30T18:59:59.000Z",
        "reminder": null,
        "interval": "09:00,18:00",
        "notes": "Don't worry, be happy!",
        "address": null,
        "userId": 1,
        "createdAt": "2020-04-28T16:39:11.000Z",
        "updatedAt": "2020-04-28T16:39:11.000Z"
    },
    {
        "id": 2,
        "name": "Nexium",
        "dosage": "40",
        "dosageType": "mg",
        "dosageSize": null,
        "timesPerDay": 2,
        "start": "2000-01-31T19:00:00.000Z",
        "expiry": "2000-04-30T18:59:59.000Z",
        "reminder": null,
        "interval": "09:00,18:00",
        "notes": "Don't worry, be happy!",
        "address": null,
        "userId": 1,
        "createdAt": "2020-04-28T16:39:11.000Z",
        "updatedAt": "2020-04-28T16:39:11.000Z"
    }]''';