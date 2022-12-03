import 'package:dartz/dartz.dart';
import 'package:web_demo_ner/domain/predict_ner_repository.dart';
import 'package:web_demo_ner/domain/result_ner_entity.dart';

import '../base/base_usecase.dart';
import '../base/error/failures.dart';

class PredictNerUseCase extends BaseUseCase<Either<Failure, ResultNerEntity>, String>{
  final PredictNerRepository predictNerRepository;

  PredictNerUseCase(this.predictNerRepository);
  @override
  Future<Either<Failure, ResultNerEntity>> call(String params) async {
    return await predictNerRepository.predictNer(params);
  }

}