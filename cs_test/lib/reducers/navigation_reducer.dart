import 'package:redux/redux.dart';

import 'package:cs_test/models/models.dart';
import 'package:cs_test/actions/actions.dart';

Reducer<NavigationStateRepository> navigationStateReducer =
    combineReducers<NavigationStateRepository>([
  TypedReducer<NavigationStateRepository, NavigateBodyAction>(
      _navigateBodyReducer),
  TypedReducer<NavigationStateRepository, NavigateRootAction>(
      _navigateRootReducer)
]);

NavigationStateRepository _navigateBodyReducer(
    NavigationStateRepository repository, NavigateBodyAction action) {
  return repository.copyWith(
      bodyPage: action.path, bodyPageTitle: action.title);
}

NavigationStateRepository _navigateRootReducer(
    NavigationStateRepository repository, NavigateRootAction action) {
  return repository.copyWith(rootPage: action.path);
}
