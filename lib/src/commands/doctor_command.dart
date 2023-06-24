import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/process_run.dart';

/// {@template sample_command}
///
/// `yanyan sample`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
class DoctorCommand extends Command<int> {
  /// {@macro sample_command}
  DoctorCommand({
    required Logger logger,
  }) : _logger = logger {}

  @override
  String get description => 'A doctor command that check everything is ok';

  @override
  String get name => 'doctor';

  final Logger _logger;

  @override
  Future<int> run() async {
    var shell = Shell(
        //verbose: false,
        );

    // final generateProgress = _logger.progress('flutter doctor');

    try {
      await shell.run(
        'flutter doctor',
        onProcess: (process) {},
      );

      // generateProgress.complete('flutter doctor success ...');
      // final generateProgress2 = _logger.progress('npm doctor');

      await shell.run(
        'npm doctor',
        onProcess: (process) {},
      );
      // generateProgress.complete('npm doctor success ...');

      shell = shell.popd();
    } on ShellException catch (e) {
      // generateProgress.fail();
      _logger.err('yanyan doctor fail ${e.hashCode}');
      return e.hashCode;
    } catch (e) {
      // generateProgress.fail();
      _logger.err('yanyan doctor fail $e');
      return e.hashCode;
    }

    return ExitCode.success.code;
  }
}
