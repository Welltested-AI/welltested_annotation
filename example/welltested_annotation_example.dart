import 'package:welltested_annotation/welltested_annotation.dart';

void main() {
  var testClass = TestClass();
}

@Welltested(excludedMethods: ['myMethod'])
class TestClass {}
