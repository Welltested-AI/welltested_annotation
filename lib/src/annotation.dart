/*
 * Created on January 2nd 2024
 *
 * Copyright (C) 2023 Welltested AI - All Rights Reserved
 * The code in this file is Intellectutal Property of Welltested AI.
 * and can't be edited, redistributed or used without a valid license of it's product (Welltested)[https://welltested.ai]
 */

///Annotate classes with [Welltested] to generate unit tests for it's methods.
///
///Param: [excludedMethods] accepts functions to be excluded from testing.
class Welltested {
  final List<String> excludedMethods;
  final List<String> supportingClasses;

  const Welltested({
    this.excludedMethods = const [],
    this.supportingClasses = const [],
  });
}

class Testcases {
  final List<String> testcases;
  const Testcases(
    this.testcases,
  );
}