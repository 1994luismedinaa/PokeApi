import 'package:dio/dio.dart';
import 'package:pokeapi/model/pokemonlistresponse.dart';
import 'package:retrofit/retrofit.dart';

part 'pokemon_api.g.dart';

@RestApi(baseUrl: "https://pokeapi.co/api/v2/")
abstract class PokemonApi {
  factory PokemonApi(Dio dio, {String baseUrl}) = _PokemonApi;

  @GET('pokemon')
  Future<PokemonListResponse> getPokemonList({
    @Query('limit') int? limit,
    @Query('offset') int? offset,

  });

  @GET("pokemon/{id}")
  Future<PokemonListResponse> getPokemon(@Path("id") int id);
}