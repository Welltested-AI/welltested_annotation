/*
 * Created on January 2nd 2024
 *
 * Copyright (C) 2023 Welltested AI - All Rights Reserved
 * The code in this file is Intellectutal Property of Welltested AI.
 * and can't be edited, redistributed or used without a valid license of it's product (Welltested)[https://welltested.ai]
 */

import 'enums.dart';

/// Base class for writing integration testing config class. These config classes
/// will be used to determine setups and expected test flows that needs to be
/// covered during the test generation. Properties of base class:
/// - `setup`: The prequisite information/instruction to test the
/// flow. For example, if you want to test if the login flow is working succuessful.
/// In this case the `setup` can be something like 'Open the app'.
/// - `testFlow`: The list of flows for which you want to generate the tests.
/// Building upon the last example. The parameter can contain flows:
/// `testFlows = ['On login Screen, entering user@gmail.com/12345678 and logging in takes user to the main screen', 'On the login Screen, click the button \'Forgot Password?\' and verfiy that only Email textfield is present']`
/// - `testObject`: The list of all the `Object`(classes and global methods) that contain
/// the relevant code for [Welltested] to generate the integration test. For the
/// example above: `testObjects=[main, MyApp, Login]`
/// - `testFramework`: It accepts enum of type `TestFramework`. By default this
/// is equal to `TestFramework.Flutter`
///
/// Example of **WelltestedIntegrationTest** config class:
/// ```dart
/// class LoginTests extends WelltestedIntegrationTest {
///   @override
///   String get setup => "Open the app";
///
///   @override
///   List<String> get testFlows => [
///         'On login Screen, entering user@gmail.com/12345678 and logging in takes user to the main screen',
///         'On login Screen, click the button \'Forgot Password?\' and verfiy that only mail textfield is present'
///       ];
///
///   @override
///   List<Object> get testObjects => [main, MyApp, Login, MainScreen];
/// }
/// ```
///
/// `setup`, `testFlows`, and `testObjects` should be overidden evertime you
/// create a new **WelltestedIntegrationTest** config class with relevant
///  information.
abstract class WelltestedIntegrationTest {
  String get setup;
  List<String> get testFlows;
  List<Object> get testObjects;
  TestFramework get testFramework => TestFramework.Flutter;
}
