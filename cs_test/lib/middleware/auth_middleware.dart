import 'package:redux/redux.dart';

import 'package:cs_test/state.dart';
import 'package:cs_test/models/models.dart';
import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/api/apis.dart';

Middleware<GlobalAppState> buildHandleLogInMiddleware(AuthAPI authAPI, UserAPI userAPI) {
  return (Store<GlobalAppState> store, action, NextDispatcher next) async {
    if (store.state.apiStateRepository.authState.loadingStatus == LoadingStatus.loading) return;

    // Determine LogIn Method
    store.dispatch(AuthAPIStateAction( status: LoadingStatus.loading, code: 0, message: '' ));

    bool hasAuthToken = action.authToken != null && action.authToken.isNotEmpty;
    bool hasCredentials = (action.email != null && action.email.isNotEmpty) && (action.password != null && action.password.isNotEmpty);

    if (hasAuthToken == true && hasCredentials == false) {
      _handleGetUserWithToken(authAPI, userAPI, store, action.authToken);
    } else if (hasCredentials == true) {
      _handleGetAuthToken(authAPI, userAPI, store, action.email, action.password);
    } else {
      store.dispatch(AuthAPIStateAction( status: LoadingStatus.failed, code: 0, message: 'Could not obtain auth token' ));
    }
  };
}

buildHandleLogOutMiddleware(AuthAPI api) {
  return (Store<GlobalAppState> store, LogOutAction action, NextDispatcher next) async {
    next(action);
  };
}

buildHandleLogInSuccessMiddleware(AuthAPI api) {
  return (Store<GlobalAppState> store, LogInSuccessAction action, NextDispatcher next) async {
    next(LogInSuccessAction(action.user, action.authToken));
  };
}

void _handleGetAuthToken(AuthAPI authAPI, UserAPI userAPI, Store<GlobalAppState> store, String email, String password) async {
  APIResponse<String> fetchTokenResponse = await authAPI.authLogin(email: email, password: password);
  if (!fetchTokenResponse.isOk) {
    store.dispatch(AuthAPIStateAction(status: LoadingStatus.failed, code: fetchTokenResponse.status, message: fetchTokenResponse.message));
  } else {
    return _handleGetUserWithToken(authAPI, userAPI, store, fetchTokenResponse.result);
  }
}

void _handleGetUserWithToken(AuthAPI authAPI, UserAPI userAPI, Store<GlobalAppState> store, String token) async {
    // Loaded auth token, try to fetch the user
    APIResponse<User> fetchUserResponse = await userAPI.getUserByToken(token);
    if (!fetchUserResponse.isOk) {
      // Could not fetch user
      store.dispatch(AuthAPIStateAction(status: LoadingStatus.failed, code: fetchUserResponse.status, message: fetchUserResponse.message));
    } else {
      store.dispatch(LogInSuccessAction(fetchUserResponse.result, token));
      store.dispatch(AuthAPIStateAction(status: LoadingStatus.success, code: fetchUserResponse.status, message: 'OK' ));
    }
}