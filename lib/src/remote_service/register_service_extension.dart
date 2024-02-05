import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Registers a service extension method with the given name (full name
/// "ext.flutter.name").
///
/// The given callback is called when the extension method is called. The
/// callback must return a [Future] that either eventually completes to a
/// return value in the form of a name/value map where the values can all be
/// converted to JSON using `json.encode()` (see [JsonEncoder]), or fails. In
/// case of failure, the failure is reported to the remote caller and is
/// dumped to the logs.
///
/// The returned map will be mutated.
///
/// {@template flutter.foundation.BindingBase.registerServiceExtension}
/// A registered service extension can only be activated if the vm-service
/// is included in the build, which only happens in debug and profile mode.
/// Although a service extension cannot be used in release mode its code may
/// still be included in the Dart snapshot and blow up binary size if it is
/// not wrapped in a guard that allows the tree shaker to remove it (see
/// sample code below).
///
/// {@tool snippet}
/// The following code registers a service extension that is only included in
/// debug builds.
///
/// ```dart
/// void myRegistrationFunction() {
///   assert(() {
///     // Register your service extension here.
///     return true;
///   }());
/// }
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// A service extension registered with the following code snippet is
/// available in debug and profile mode.
///
/// ```dart
/// void myOtherRegistrationFunction() {
///   // kReleaseMode is defined in the 'flutter/foundation.dart' package.
///   if (!kReleaseMode) {
///     // Register your service extension here.
///   }
/// }
/// ```
/// {@end-tool}
///
/// Both guards ensure that Dart's tree shaker can remove the code for the
/// service extension in release builds.
/// {@endtemplate}
void registerServiceExtension({
  required String name,
  required ServiceExtensionCallback callback,
}) {
  final String methodName = 'ext.welltested.$name';
  developer.registerExtension(methodName,
      (String method, Map<String, String> parameters) async {
    assert(method == methodName);
    assert(() {
      if (debugInstrumentationEnabled) {
        debugPrint('service extension method received: $method($parameters)');
      }
      return true;
    }());

    // VM service extensions are handled as "out of band" messages by the VM,
    // which means they are handled at various times, generally ASAP.
    // Notably, this includes being handled in the middle of microtask loops.
    // While this makes sense for some service extensions (e.g. "dump current
    // stack trace", which explicitly doesn't want to wait for a loop to
    // complete), Flutter extensions need not be handled with such high
    // priority. Further, handling them with such high priority exposes us to
    // the possibility that they're handled in the middle of a frame, which
    // breaks many assertions. As such, we ensure they we run the callbacks
    // on the outer event loop here.
    await debugInstrumentAction<void>('Wait for outer event loop', () {
      return Future<void>.delayed(Duration(seconds: 5));
    });

    late Map<String, dynamic> result;
    try {
      result = await callback(parameters);
    } catch (exception, stack) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: exception,
        stack: stack,
        context: ErrorDescription(
            'during a service extension callback for "$method"'),
      ));
      return developer.ServiceExtensionResponse.error(
        developer.ServiceExtensionResponse.extensionError,
        json.encode(<String, String>{
          'exception': exception.toString(),
          'stack': stack.toString(),
          'method': method,
        }),
      );
    }
    result['type'] = '_extensionType';
    result['method'] = method;
    return developer.ServiceExtensionResponse.result(json.encode(result));
  });
}
