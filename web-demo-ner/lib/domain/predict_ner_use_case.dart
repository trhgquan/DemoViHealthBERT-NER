import 'package:dartz/dartz.dart';
import 'package:demoner/base/base_usecase.dart';
import 'package:demoner/domain/predict_ner_repository.dart';
import 'package:demoner/domain/result_ner_entity.dart';

import '../base/error/failures.dart';

class PredictNerUseCase extends BaseUseCase<Either<Failure, ResultNerEntity>, String>{
  final PredictNerRepository predictNerRepository;

  PredictNerUseCase(this.predictNerRepository);
  @override
  Future<Either<Failure, ResultNerEntity>> call(String params) async {
    return await predictNerRepository.predictNer(params);
  }

}