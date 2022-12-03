import 'package:demoner/views/bloc/predict_ner_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/predict_ner_remote_data_source.dart';
import 'data/predict_ner_repositoryimpl.dart';
import 'domain/predict_ner_repository.dart';
import 'domain/predict_ner_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => PredictNerBloc(predictNerUseCase: sl()));

  sl.registerLazySingleton(() => PredictNerUseCase(sl()));

  sl.registerLazySingleton<PredictNerRepository>(
      () => PredictNerRepositoryImpl(sl()));

  sl.registerLazySingleton<PredictNerRemoteDataSource>(
      () => PredictNerRemoteDataSourceImpl());
}
