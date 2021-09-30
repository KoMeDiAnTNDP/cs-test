import 'package:cs_test/models/models.dart';


class LogInAction {
  final String authToken;
  final String email;
  final String password;

  LogInAction({ this.authToken, this.email, this.password });
}

class LogInSuccessAction {
  final User user;
  final String authToken;
  LogInSuccessAction(this.user, this.authToken);

  @override
  toString() {
    return 'LogInSuccessAction{user: $user, authToken: $authToken}';
  }
}

class LogOutAction {
  LogOutAction();
}