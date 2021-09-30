import 'package:cs_test/models/models.dart';

class AuthStateRepository {
  final User user;
  final String authToken;

  AuthStateRepository({ this.user, this.authToken });
  
  AuthStateRepository copyWith({ User user, String authToken }) {
    return AuthStateRepository(
      user: user ?? this.user,
      authToken: authToken ?? this.authToken
    );
  }

  @override
  int get hashCode => user.hashCode ^ authToken.hashCode;

  bool get isAuthoized => user != null && user.isValid && authToken.isNotEmpty;
  bool get isNotAuthorized => !isAuthoized;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is AuthStateRepository &&
      user == other.user &&
      authToken == other.authToken;

  @override String toString() {
    return 'AuthStateRepository{user: $user, authToken: $authToken}';
  }

  factory AuthStateRepository.createEmpty() => AuthStateRepository(authToken: null, user: User.createEmpty());
}