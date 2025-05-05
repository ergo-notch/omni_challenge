import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:omni_challenge/features/characters/domain/use_cases/add_characters_by_page_use_case.dart';
import 'package:omni_challenge/core/core.dart';

class MockRepository extends Mock implements IRepository {}

void main() {
  late MockRepository mockRepository;
  late AddCharactersByPageUseCase useCase;

  setUp(() {
    mockRepository = MockRepository();
    useCase = AddCharactersByPageUseCase(repository: mockRepository);
  });

  group('AddCharactersByPageUseCase', () {
    group('Success cases', () {
      test(
        'returns characters from repository and determines isLastPage=false',
        () async {
          final characters = [
            CharacterEntity(
              id: '1',
              name: 'Rick',
              status: CharacterStatus.alive,
              imageUrl: '',
            ),
          ];

          final repositoryResponse = CharactersListEntity(
            count: 2,
            results: characters,
            next: 2,
          );

          when(
            () => mockRepository.getCharacters(page: 1),
          ).thenAnswer((_) async => Right(repositoryResponse));

          final result = await useCase.call(AddCharactersByPageUseCaseParams());

          result.fold(
            (error) => fail('Expected Right but got Left: ${error.message}'),
            (data) {
              expect(data.result.results, characters);
              expect(data.result.count, 2);
              expect(data.result.next, 2);
              expect(data.isLastPage, false);
            },
          );
        },
      );

      test('returns isLastPage=true when total results are reached', () async {
        final allCharacters = [
          CharacterEntity(
            id: '1',
            name: 'Rick',
            status: CharacterStatus.alive,
            imageUrl: '',
          ),
          CharacterEntity(
            id: '2',
            name: 'Morty',
            status: CharacterStatus.alive,
            imageUrl: '',
          ),
        ];

        final repositoryResponse = CharactersListEntity(
          count: 2,
          results: [
            CharacterEntity(
              id: '2',
              name: 'Morty',
              status: CharacterStatus.alive,
              imageUrl: '',
            ),
          ],
          next: null,
        );

        when(
          () => mockRepository.getCharacters(page: 2),
        ).thenAnswer((_) async => Right(repositoryResponse));

        final result = await useCase.call(
          AddCharactersByPageUseCaseParams(
            page: 2,
            characters: [allCharacters[0]],
          ),
        );

        result.fold(
          (error) => fail('Expected Right but got Left: ${error.message}'),
          (data) {
            expect(data.result.results?.length, 2);
            expect(data.result.next, null);
            expect(data.isLastPage, true);
          },
        );
      });

      test('returns cached results when isLastPage param is true', () async {
        final characters = [
          CharacterEntity(
            id: '1',
            name: 'Rick',
            status: CharacterStatus.alive,
            imageUrl: '',
          ),
        ];

        final result = await useCase.call(
          AddCharactersByPageUseCaseParams(
            page: 1,
            characters: characters,
            isLastPage: true,
          ),
        );

        result.fold(
          (error) => fail('Expected Right but got Left: ${error.message}'),
          (data) {
            expect(data.result.results, characters);
            expect(data.result.next, null);
            expect(data.isLastPage, true);
          },
        );

        verifyNever(
          () => mockRepository.getCharacters(page: any(named: 'page')),
        );
      });
    });
  });

  group('Error cases', () {
    test('returns Left when repository fails', () async {
      when(() => mockRepository.getCharacters(page: 1)).thenAnswer(
        (_) async => Left(GraphQLErrorException(message: 'Repository error')),
      );

      final result = await useCase.call(AddCharactersByPageUseCaseParams());

      result.fold((error) {
        expect(error, isA<GraphQLErrorException>());
        expect(error.message, 'Repository error');
      }, (_) => fail('Expected Left but got Right'));
    });
  });
}
