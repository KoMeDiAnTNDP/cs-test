import 'package:meta/meta.dart';
import 'package:cs_test/models/models.dart';
import 'package:cs_test/routes.dart';

// The State of the app which will get propogated to most Widgets through the Store
// The app State properties should be immutable as we do not modify them directly from our Widgets
class GlobalAppState {
  final AuthStateRepository authStateRepository;
  final APIStateRepository apiStateRepository;
  final NavigationStateRepository navigationStateRepository;
  final DataStateRepository dataStateRepository;

  const GlobalAppState({
    @required this.authStateRepository,
    @required this.apiStateRepository,
    @required this.navigationStateRepository,
    @required this.dataStateRepository,
  });

  // Initializer/factory for app initialization
  GlobalAppState.initialState() : 
    authStateRepository = AuthStateRepository.createEmpty(),
    apiStateRepository = APIStateRepository.createEmpty(),
    navigationStateRepository = NavigationStateRepository(
      rootPage: Routes.login,
      bodyPage: Routes.medications,
      bodyPageTitle: Routes.medicationsTitle),
    dataStateRepository = DataStateRepository.createEmpty();

  @override
  int get hashCode => authStateRepository.hashCode ^ 
  apiStateRepository.hashCode ^ 
  navigationStateRepository.hashCode ^
  dataStateRepository.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is GlobalAppState &&
    other.authStateRepository == authStateRepository &&
    other.apiStateRepository == apiStateRepository &&
    other.navigationStateRepository == navigationStateRepository &&
    other.dataStateRepository == dataStateRepository;

  GlobalAppState copyWith({
    AuthStateRepository authStateRepository,
    APIStateRepository apiStateRepository,
    NavigationStateRepository navigationStateRepository,
    DataStateRepository dataStateRepository
  }) => GlobalAppState(
    authStateRepository: authStateRepository ?? this.authStateRepository,
    apiStateRepository: apiStateRepository ?? this.apiStateRepository,
    navigationStateRepository: navigationStateRepository ?? this.navigationStateRepository,
    dataStateRepository: dataStateRepository ?? this.dataStateRepository
  );
}
