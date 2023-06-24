import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:yanyan/src/commands/sub_commands/create_flutter_command.dart';

class CreateCommand extends Command<int> {
  CreateCommand({
    required Logger logger,
  }) {
    addSubcommand(CreateFlutterCommand(logger: logger));
  }

  @override
  String get summary => '$invocation\n$description';

  @override
  String get description => 'create new flutter project';

  @override
  String get name => 'create';
  @override
  String get invocation =>
      'yanyan create <subcommand> <project-name> [arguments]';
}
