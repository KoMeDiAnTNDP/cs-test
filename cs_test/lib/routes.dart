import 'package:cs_test/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/pages/pages.dart';
import 'package:cs_test/state.dart';

class Routes {
  static const home = '/home';
  static const login = '/login';

  static const medications = '/medications';
  static const medicationsTitle = 'Medications';

  static Map<String, WidgetBuilder> buildRoutes(Store<GlobalAppState> store) => {
    Routes.login: (BuildContext context) => LoginPage(key: Key('page-login')),
    Routes.home: (BuildContext context) => HomePage(key: Key('page-home'))
  };

  static Widget buildHomeRouteWidget(String path, BuildContext context, TabController tabController) {
    switch (path) {
      case Routes.medications:
        return MedicationPage(key: Key('page-medication'), tabController: tabController,);
      default:
        return Container(
          key: Key('page-invalid'),
          alignment: Alignment.center,
          child: Text(
            'Invalid Path $path',
            style: Theme.of(context).textTheme.headline
          )
        );
    }
  }
}