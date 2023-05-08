enum DinnerHoursType {
  breakFast(1),
  lunch(2),
  dinner(3);

  final int value;
  const DinnerHoursType(this.value);

  factory DinnerHoursType.intToDinnerHoursType(int value) {
    List<DinnerHoursType> enumValues = DinnerHoursType.values;

    for(final enumValue in enumValues) {
      if(enumValue.value == value) {
        return enumValue;
      }
    }

    throw ArgumentError('Invalid value: $value');
  }
}