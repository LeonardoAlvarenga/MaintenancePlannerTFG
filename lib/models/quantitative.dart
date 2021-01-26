import 'package:flutter/foundation.dart';

class Quantitative {
  final DateTime id;
  final String parameterName;
  final double minValue;
  final double maxValue;
  final String unitName;

  Quantitative({
    @required this.id,
    @required this.parameterName,
    @required this.minValue,
    @required this.maxValue,
    @required this.unitName,
  });
}
