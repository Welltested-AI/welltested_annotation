/*
 * Created on August 19th 2023
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

  const Welltested({
    this.excludedMethods = const [],
  });
}

class Testcases {
  final List<String> testcases;
  const Testcases(
    this.testcases,
  );
}
