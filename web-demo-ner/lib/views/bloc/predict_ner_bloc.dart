import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo_ner/views/bloc/predict_ner_event.dart';
import 'package:web_demo_ner/views/bloc/predict_ner_state.dart';

import '../../base/error/failures.dart';
import '../../domain/predict_ner_use_case.dart';
import '../../domain/result_ner_entity.dart';
import '../../utils/color_utils.dart';

class PredictNerBloc extends Bloc<PredictNerEvent, PredictNerState> {
  final PredictNerUseCase predictNerUseCase;

  PredictNerBloc({required PredictNerUseCase predictNerUseCase})
      : this.predictNerUseCase = predictNerUseCase,
        super(PredictNerInitState());

  @override
  Stream<PredictNerState> mapEventToState(PredictNerEvent event) async* {
    if (event is PredictNerInputTextEvent) {
      // yield PredictNerLoadingState();
      final data = await predictNerUseCase.call(event.text);
      yield* _mapToPredictNerSuccessState(data);
    }
  }

  WidgetSpan _mapToWidgetSpan(ResultEntity resultEntity) {
    switch (resultEntity.label) {
      case "B-DATE":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_yellow_600,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-DATE":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_orange_500,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-NAME":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_ocean_blue_200,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-AGE":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_cyan_400,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-LOCATION":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_green_500,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-LOCATION":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_ocean_blue_300,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-JOB":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_gray_200,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-JOB":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_red_100,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-ORGANIZATION":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_yellow_200,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-ORGANIZATION":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_blue_500,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-PATIENT_ID":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_orange_300,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-SYMPTOM_AND_DISEASE":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_gray_100,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-SYMPTOM_AND_DISEASE":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_purple_600,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-GENDER":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_yellow_600,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "B-TRANSPORTATION":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_cyan_300,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-TRANSPORTATION":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_gray_200,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-NAME":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_yellow_300,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-PATIENT_ID":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_red_600,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-AGE":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_yellow_600,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
      case "I-GENDER":
        {
          return WidgetSpan(
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorUtils.color_cyan_600,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.token,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  WidgetSpan(
                      child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      resultEntity.label,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ))
                ]),
              ),
            ),
          );
        }
    }
    return WidgetSpan(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
        margin: const EdgeInsets.only(right: 6.0, bottom: 8.0),
        child: Text(
          resultEntity.token,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Stream<PredictNerState> _mapToPredictNerSuccessState(
      Either<Failure, ResultNerEntity> entity) async* {
    final List<WidgetSpan> widgetSpans = [];
    final List<Widget> widgetSymptoms = [];
    yield entity.fold((l) => Error(), (data) {
      for (var element in data.listData) {
        widgetSpans.add(_mapToWidgetSpan(element));
      }
      for (var element in data.symptoms) {
        widgetSymptoms.add(Container(
          decoration: const BoxDecoration(
            color: ColorUtils.color_purple_300,
            borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(8.0),
          child: Text(element),
        ));
      }
      return PredictNerSuccessState(widgetSpans, widgetSymptoms);
    });
  }
}
