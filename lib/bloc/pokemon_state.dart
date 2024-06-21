part of 'pokemon_bloc.dart';
 
@freezed
class PokemonState with _$PokemonState {
  const factory PokemonState.initial() = _Initial;
  const factory PokemonState.loadInProgress() = LoadInProgress;
  const factory PokemonState.loadSuccess(List<Pokemon> pokemonList) = _LoadSuccess;
  const factory PokemonState.loadFailure() = _LoadFailure;
}