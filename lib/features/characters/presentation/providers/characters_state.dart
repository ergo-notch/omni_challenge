import 'package:omni_challenge/core/core.dart';
import 'package:omni_challenge/core/utils/fetch_status.dart';

class CharactersState {
  final FetchStatus status;
  final String? errorMessage;
  final num? nextPage;
  final num? totalResults;
  final List<CharacterEntity> characters;

  const CharactersState({
    this.status = FetchStatus.initial,
    this.errorMessage,
    this.nextPage,
    this.totalResults,
    this.characters = const [],
  });

  CharactersState copyWith({
    FetchStatus? status,
    String? errorMessage,
    num? nextPage,
    num? totalResults,
    List<CharacterEntity>? characters,
  }) {
    return CharactersState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      nextPage: nextPage ?? this.nextPage,
      totalResults: totalResults ?? this.totalResults,
      characters: characters ?? this.characters,
    );
  }
}
