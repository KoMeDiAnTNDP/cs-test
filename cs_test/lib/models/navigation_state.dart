import 'package:flutter/material.dart';

class NavigationStateRepository {
  /// The bottommost page in the stack (Splash, LogIn or Home)
  final String rootPage;

  /// The page displayed as the body of the Home page
  final String bodyPage;

  /// The title of the page displayed as the body of the Home page
  final String bodyPageTitle;

  NavigationStateRepository({
    @required this.rootPage,
    @required this.bodyPage,
    @required this.bodyPageTitle
  });

  @override
  get hashCode =>
      rootPage.hashCode ^
      bodyPage.hashCode ^
      bodyPageTitle.hashCode;

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationStateRepository &&
          other.rootPage == rootPage &&
          other.bodyPage == bodyPage &&
          other.bodyPageTitle == bodyPageTitle;

  @override
  toString() =>
      'NavigationStateRepository{rootPage: $rootPage, bodyPage: $bodyPage, bodyPageTitle: $bodyPageTitle}';

  NavigationStateRepository copyWith(
          {String rootPage,
          String bodyPage,
          String bodyPageTitle,
          int numOfListedItems}) =>
      NavigationStateRepository(
        rootPage: rootPage ?? this.rootPage,
        bodyPage: bodyPage ?? this.bodyPage,
        bodyPageTitle: bodyPageTitle ?? this.bodyPageTitle
      );

  factory NavigationStateRepository.createEmpty() => NavigationStateRepository(
      rootPage: null, bodyPage: null, bodyPageTitle: null);
}
