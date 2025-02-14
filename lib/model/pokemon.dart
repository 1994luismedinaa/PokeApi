import 'package:freezed_annotation/freezed_annotation.dart';
 
part 'pokemon.freezed.dart';
part 'pokemon.g.dart';
 
@freezed
class Pokemon with _$Pokemon {
  factory Pokemon({
    String? id,
    String? name,
    String? url,
    int? height,
    int? weight,
  }) = _Pokemon;
  const Pokemon._();
 
  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
 
  String? get image {
    return '$imageUrl$pokemonId.png';
  }
 
  String? get pokemonId => id?.toString() ?? url?.split('/').elementAt(6);
 
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/';
}
 