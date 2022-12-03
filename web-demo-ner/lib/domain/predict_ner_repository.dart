import 'package:dartz/dartz.dart';
import 'package:web_demo_ner/domain/result_ner_entity.dart';

import '../base/error/failures.dart';

abstract class PredictNerRepository{
  Future<Either<Failure, ResultNerEntity>> predictNer(String text);
}