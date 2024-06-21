part of 'pokemon_bloc.dart';
 
@freezed
class PokemonEvent with _$PokemonEvent {
  const factory PokemonEvent.load() = _Load;
  const factory PokemonEvent.listenPokemonList() = _ListenPokemonList;
}
 