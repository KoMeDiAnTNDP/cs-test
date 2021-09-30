import 'package:cs_test/models/models.dart';

abstract class APIStateAction {
  LoadingStatus status;
  int code;
  String message;

  @override
  toString() => 'APIStateAction{status: $status, code: $code, message: $message}';

  APIStateAction({
    this.status = LoadingStatus.success,
    this.code = 200,
    this.message = 'OK'
  });
}

class AuthAPIStateAction extends APIStateAction {
  AuthAPIStateAction({ LoadingStatus status, int code, String message}) : super(status: status, code: code, message: message);
  factory AuthAPIStateAction.idle() => AuthAPIStateAction(status: LoadingStatus.idle, code: 0, message: '');

  @override
  toString() => 'AuthAPIStateAction{status: $status, code: $code, message: $message}';
}

class MedicationAPIStateAction extends APIStateAction {
  MedicationAPIStateAction({ LoadingStatus status, int code, String message}) : super(status: status, code: code, message: message);
  factory MedicationAPIStateAction.idle() => MedicationAPIStateAction(status: LoadingStatus.idle, code: 0, message: '');
  
  @override
  toString() => 'MedicationAPIStateAction{status: $status, code: $code, message: $message}';
}