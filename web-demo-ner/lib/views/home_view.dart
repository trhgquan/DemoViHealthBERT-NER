import 'dart:io';

import 'package:demoner/utils/color_utils.dart';
import 'package:demoner/views/bloc/predict_ner_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';
import 'bloc/predict_ner_bloc.dart';
import 'bloc/predict_ner_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _controller;

  PredictNerBloc get bloc => BlocProvider.of<PredictNerBloc>(context);

  BuildContext get currentContext => context;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PredictNerBloc>(
      create: (BuildContext context) => bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('NER TASK')),
        body: Column(
          children: [
            Wrap(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_red_300,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "O",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_yellow_600,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-DATE",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_orange_500,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-DATE",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_ocean_blue_200,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-NAME",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_cyan_400,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-AGE",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_yellow_600,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-AGE",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_green_500,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-LOCATION",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_ocean_blue_300,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-LOCATION",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_gray_200,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-JOB",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_red_100,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-JOB",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_yellow_200,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-ORGANIZATION",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_blue_500,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-ORGANIZATION",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_orange_300,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-PATIENT_ID",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_red_600,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-PATIENT_ID",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_gray_100,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-SYMPTOM_AND_DISEASE",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_purple_600,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-SYMPTOM_AND_DISEASE",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_yellow_600,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-GENDER",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_cyan_600,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-GENDER",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_cyan_300,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "B-TRANSPORTATION",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_gray_200,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-TRANSPORTATION",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorUtils.color_yellow_300,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: const Text(
                    "I-NAME",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Nhập dữ liệu",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                        color: ColorUtils.color_red_300, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                        color: ColorUtils.color_red_300, width: 2.0),
                  ),
                ),
                onSubmitted: (String value) async {
                  bloc.add(PredictNerInputTextEvent(value));
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: BlocBuilder<PredictNerBloc, PredictNerState>(
                  builder: (context, state) {
                if (state is PredictNerSuccessState) {
                  return Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: state.widgetSpans,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: ColorUtils.color_green_300,
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                        ),
                        child: const Text(
                          "Xuất hiện triệu chứng",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Wrap(
                        children: state.widgetSymptoms,
                      )
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
