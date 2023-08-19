import 'package:welltested_annotation/welltested_annotation.dart';

void main() {
  final testClass = TestClass();
  print(testClass.add(1, 2));
}

@Welltested(excludedMethods: ['multiply'])
class TestClass {
  int multiply(int a, int b) {
    return a * b;
  }

  @Testcases(['result should be 3 if a=1 and b=2'])
  int add(int a, int b) {
    return a + b;
  }
}
