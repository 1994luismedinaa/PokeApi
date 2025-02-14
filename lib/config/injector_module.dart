import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pokeapi/data/pokemon_api.dart';
import 'package:pokeapi/model/pokemon.dart';

@module
abstract class InjectorModule {
  @lazySingleton
  PokemonApi get pokemonApi {
    final dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
        },
      ),
    )..interceptors.addAll([
        DioCacheInterceptor(options: cacheOptions),
        LogInterceptor(),
      ]);
    return PokemonApi(dio);
  }

  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    hitCacheOnErrorExcept: [401, 403],
    priority: CachePriority.normal,
    maxStale: const Duration(days: 1),
  );
}
