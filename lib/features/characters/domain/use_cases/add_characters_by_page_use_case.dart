import 'package:omni_challenge/core/core.dart';

final addCharactersByPageUseCaseProvider = Provider<AddCharactersByPageUseCase>(
  (ref) => AddCharactersByPageUseCase(repository: ref.read(repositoryProvider)),
);

class AddCharactersByPageUseCase
    extends UseCase<CharactersListEntity, AddCharactersByPageUseCaseParams> {
  final IRepository repository;

  AddCharactersByPageUseCase({required this.repository});

  @override
  Future<Either<GraphQLErrorException, CharactersListEntity>> call(
    AddCharactersByPageUseCaseParams params,
  ) async {
    final response = await repository.getCharacters(page: params.page);
    return response.fold((error) => Left(error), (success) {
      List<CharacterEntity> results = [
        ...params.characters,
        ...success.results ?? [],
      ];
      return Right(
        CharactersListEntity(
          count: results.length,
          results: results,
          next: success.next,
        ),
      );
    });
  }
}

class AddCharactersByPageUseCaseParams {
  final num page;
  final List<CharacterEntity> characters;

  AddCharactersByPageUseCaseParams({this.page = 1, this.characters = const []});
}
