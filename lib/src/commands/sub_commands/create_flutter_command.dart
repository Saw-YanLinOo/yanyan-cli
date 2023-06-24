import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/process_run.dart';

class CreateFlutterCommand extends Command<int> {
  CreateFlutterCommand({
    required Logger logger,
  }) : _logger = logger {
    // argParser.addFlag(name)
  }

  @override
  String get description => 'create new flutter project';

  @override
  String get name => 'flutter';

  final Logger _logger;

  @override
  FutureOr<int>? run() async {
    final arg = argResults?.arguments[0];

    var shell = Shell(
      verbose: false,
    );

    final generateProgress = _logger.progress('create flutter app');

    try {
      await shell.run(
        'flutter create $arg',
        onProcess: (process) {},
      );

      generateProgress.complete('Successful');
      _logger.success('flutter create success...');

      shell = shell.pushd('$arg');
      await shell.run(
        'flutter pub get',
        onProcess: (process) {},
      );
      _logger.success('flutter pub get success...');

      shell = shell.popd();
    } on ShellException catch (e) {
      generateProgress.fail();
      _logger.err('flutter create fail ${e.hashCode}');
      return e.hashCode;
    } catch (e) {
      generateProgress.fail();
      _logger.err('flutter create fail $e');
      return e.hashCode;
    }

    return ExitCode.success.code;
  }
}
