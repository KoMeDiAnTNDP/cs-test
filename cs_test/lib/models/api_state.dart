import 'package:cs_test/models/loading_model.dart';
import 'package:cs_test/actions/actions.dart';

class APIState {
  final LoadingStatus loadingStatus;
  final int code;
  final String message;

  APIState({
    this.loadingStatus,
    this.code,
    this.message
  });

  @override
  bool operator ==(Object other) =>
    identical(this, other) || 
      other is APIState &&
        this.loadingStatus == other.loadingStatus &&
        this.code == other.code &&
        this.message == other.message;

  @override
  int get hashCode => loadingStatus.hashCode ^ code.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'APIState{loadingStatus: $loadingStatus, code: $code, message: $message}';
  }

  factory APIState.fromAction(APIStateAction action) => new APIState(loadingStatus: action.status, code: action.code, message: action.message);
  factory APIState.emptyAPIState() => new APIState(loadingStatus: LoadingStatus.idle, code: 0, message: '');
}

class APIStateRepository {
  final APIState authState;
  final APIState medicationState;


  APIStateRepository({
    this.authState,
    this.medicationState,
  });

  APIStateRepository copyWith({ 
    APIState authState,
    APIState medicationState,
  }) {
    return APIStateRepository(
      authState: authState ?? this.authState,
      medicationState: medicationState ?? this.medicationState,
    );
  }

  factory APIStateRepository.createEmpty() =>
    new APIStateRepository(
      authState: APIState.emptyAPIState(),
      medicationState: APIState.emptyAPIState(),
    );
}