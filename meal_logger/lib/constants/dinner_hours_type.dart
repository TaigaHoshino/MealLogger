enum DinnerHoursType {
  breakFast(1),
  lunch(2),
  dinner(3);

  final int value;
  const DinnerHoursType(this.value);

  factory DinnerHoursType.intToDinnerHoursType(int value) {
    List<DinnerHoursType> enumValues = DinnerHoursType.values;
    if (value >= 0 && value < enumValues.length) {
      return enumValues[value];
    }
    else {
      throw ArgumentError('Invalid value: $value');
    }
  }
}