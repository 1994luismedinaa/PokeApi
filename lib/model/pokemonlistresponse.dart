import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokeapi/model/pokemon.dart';

part 'pokemonlistresponse.freezed.dart';
part 'pokemonlistresponse.g.dart';

@freezed
class PokemonListResponse with _$PokemonListResponse {
  factory PokemonListResponse({
    required int? count,
    required String? next,
    required String? previous,
    required List<Pokemon>? results,
  }) = _PokemonListResponse;

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseFromJson(json);
}
