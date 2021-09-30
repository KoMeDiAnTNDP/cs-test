import 'package:redux/redux.dart';

import 'package:cs_test/actions/actions.dart';
import 'package:cs_test/models/models.dart';

// combineReducers allows us to conveniently define TypedReducer functions for handling specific Actions instead of testing against Action types ourselves
Reducer<AuthStateRepository> authStateReducer = combineReducers<AuthStateRepository>([
  TypedReducer<AuthStateRepository, LogInSuccessAction>(_logInReducer),
  TypedReducer<AuthStateRepository, LogOutAction>(_logOutReducer)
]);

AuthStateRepository _logInReducer(AuthStateRepository repository, LogInSuccessAction action) {
  return repository.copyWith(authToken: action.authToken, user: action.user);
}

AuthStateRepository _logOutReducer(AuthStateRepository repository, LogOutAction action) {
  return AuthStateRepository.createEmpty();
}