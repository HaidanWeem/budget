enum OperationType {
  income,
  spending;

  static OperationType parse(String key) {
    return OperationType.values
        .firstWhere((element) => element.name == key);
  }
}
