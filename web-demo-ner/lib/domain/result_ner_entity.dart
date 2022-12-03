class ResultNerEntity {
  final List<ResultEntity> listData;
  final List<String> symptoms;

  ResultNerEntity(this.listData, this.symptoms);
}

class ResultEntity {
  final String token;
  final String label;

  ResultEntity(this.token, this.label);
}
