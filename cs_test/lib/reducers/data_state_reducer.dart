import 'package:cs_test/models/models.dart';

import 'package:cs_test/reducers/medication_reducer.dart';

DataStateRepository dataStateReducer(DataStateRepository repository, action) => 
  repository.copyWith(
    medications: medicationsReducer(repository.medications, action),
  );