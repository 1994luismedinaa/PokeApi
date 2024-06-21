import 'package:pokeapi/model/pokemon.dart';

abstract class PokemonRepository {
  Stream<List<Pokemon>> get getPokemonList;
  Future<void> loadMorePokemon();
}