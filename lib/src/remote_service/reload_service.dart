import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../remote_service/register_service_extension.dart';

typedef WelltestedExecuteCallback = Future<void> Function(
    WidgetController widgetTester);

Future<void> enableWelltestedReloadService(
    WelltestedExecuteCallback executeCallback) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  final controller = LiveWidgetController(binding);

  registerServiceExtension(
    name: 'e2e',
    callback: (Map<String, String> params) async {
      try {
        final execute = params['state'] == 'execute';
        print('executing the given steps');
        if (execute) {
          await executeCallback(controller);
        }
        return {'status': 'ok'};
      } catch (e, s) {
        return {'status': 'failure', 'exception': e, 'stacktrace': s};
      }
    },
  );
}
