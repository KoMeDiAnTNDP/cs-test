import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:cs_test/state.dart';
import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/models/models.dart';
import 'package:cs_test/routes.dart';

class LoginViewModel {
  final APIState authState;
  final Function({ String email, String password }) onUserLogin;
  final Function(BuildContext context) dispatchNavigateToHome;

  LoginViewModel({
    @required this.authState,
    @required this.onUserLogin,
    @required this.dispatchNavigateToHome
  });

  @override
  int get hashCode => authState.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is LoginViewModel &&
    other.authState == authState;

  factory LoginViewModel.create(Store<GlobalAppState> store) {
    return LoginViewModel(
      authState: store.state.apiStateRepository.authState,
      onUserLogin: ({ String email, String password }) => store.dispatch(LogInAction(email: email, password: password)),
      dispatchNavigateToHome: (BuildContext context) => store.dispatch(NavigateRootAction(Routes.home)),
    );
  }
}