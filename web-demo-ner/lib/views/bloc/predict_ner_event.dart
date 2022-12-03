class PredictNerEvent{}

class PredictNerInputTextEvent extends PredictNerEvent{
  final String text;

  PredictNerInputTextEvent(this.text);
}