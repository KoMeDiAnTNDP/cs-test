import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/state.dart';
import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/routes.dart';

class HomeViewModel {
  final String activePage;
  final String activePageTitle;
  final Function logOut;

  @override
  get hashCode => activePage.hashCode ^ activePageTitle.hashCode;

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is HomeViewModel &&
          other.activePage == activePage &&
          other.activePageTitle == activePageTitle;

  HomeViewModel({
      @required this.activePage,
      @required this.activePageTitle,
      @required this.logOut
    });

  factory HomeViewModel.create(Store<GlobalAppState> store) {
    return HomeViewModel(
        activePage: store.state.navigationStateRepository.bodyPage,
        activePageTitle: store.state.navigationStateRepository.bodyPageTitle,
        logOut: () => store.dispatch(NavigateRootAction(Routes.login))
    );
  }
}
