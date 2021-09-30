import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/state.dart';

Middleware<GlobalAppState> buildHandleNavigateRootAction(GlobalKey<NavigatorState> navigatorState) {
  return (Store<GlobalAppState> store, action, NextDispatcher next) {
    if (store.state.navigationStateRepository.rootPage == action.path) return;

    next(action);
    Future.delayed(Duration.zero).then((_) {
      navigatorState.currentState.pushReplacementNamed(action.path);
    });
  };
}