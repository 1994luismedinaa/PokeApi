import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injector.config.dart';

@InjectableInit(preferRelativeImports: false)
Future<void> configure(String environment) async {
  GetIt.instance.init(environment: environment);
}
