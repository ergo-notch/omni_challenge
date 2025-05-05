import 'package:omni_challenge/features/characters/domain/use_cases/add_characters_by_page_use_case.dart';
import 'package:omni_challenge/features/characters/presentation/providers/characters_state.dart';

import '../../../../core/core.dart';

final charactersViewModelProvider =
    StateNotifierProvider<CharactersViewModel, CharactersState>(
      (ref) => CharactersViewModel(
        getCharactersByPageUseCase: ref.watch(
          addCharactersByPageUseCaseProvider,
        ),
      ),
    );

class CharactersViewModel extends StateNotifier<CharactersState> {
  final AddCharactersByPageUseCase getCharactersByPageUseCase;
  CharactersViewModel({required this.getCharactersByPageUseCase})
    : super(const CharactersState());

  Future<void> fetchCharacters() async {
    state = state.copyWith(status: FetchStatus.fetching);
    final result = await getCharactersByPageUseCase.call(
      AddCharactersByPageUseCaseParams(
        page: state.nextPage ?? 1,
        characters: state.characters,
      ),
    );
    result.fold(
      (error) =>
          state = state.copyWith(
            status: FetchStatus.error,
            errorMessage: error.message,
          ),

      (success) =>
          state = state.copyWith(
            status: FetchStatus.success,
            nextPage: success.next,
            totalResults: success.results?.length,
            characters: success.results,
          ),
    );
  }
}
