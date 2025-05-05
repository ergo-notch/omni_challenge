import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:omni_challenge/features/characters/domain/use_cases/add_characters_by_page_use_case.dart';
import 'package:omni_challenge/features/characters/presentation/providers/characters_view_model.dart';
import 'package:omni_challenge/core/core.dart';

class MockAddCharactersByPageUseCase extends Mock
    implements AddCharactersByPageUseCase {}

class FakeAddCharactersByPageUseCaseParams extends Fake
    implements AddCharactersByPageUseCaseParams {}

void main() {
  late MockAddCharactersByPageUseCase mockUseCase;
  late ProviderContainer container;

  setUp(() {
    mockUseCase = MockAddCharactersByPageUseCase();
    container = ProviderContainer(
      overrides: [
        addCharactersByPageUseCaseProvider.overrideWithValue(mockUseCase),
      ],
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeAddCharactersByPageUseCaseParams());
  });

  tearDown(() => container.dispose());

  group('AddCharactersByPageUseCase', () {
    test('fetchCharacters loads first page successfully', () async {
      final characters = [
        CharacterEntity(
          id: '1',
          name: 'Rick',
          status: CharacterStatus.alive,
          imageUrl: '',
        ),
      ];

      final response = AddCharactersByPageUseCaseResult(
        result: CharactersListEntity(results: characters, next: 2),
        isLastPage: false,
      );

      when(
        () => mockUseCase.call(any()),
      ).thenAnswer((_) async => Right(response));

      final notifier = container.read(charactersViewModelProvider.notifier);

      await notifier.fetchCharacters();

      final state = container.read(charactersViewModelProvider);
      expect(state.status, FetchStatus.success);
      expect(state.characters, characters);
      expect(state.nextPage, 2);
      expect(state.isLastPage, false);
    });

    test('fetchCharacters accumulates characters on pagination', () async {
      final firstPageCharacters = [
        CharacterEntity(
          id: '1',
          name: 'Rick',
          status: CharacterStatus.alive,
          imageUrl: '',
        ),
      ];
      final secondPageCharacters = [
        CharacterEntity(
          id: '2',
          name: 'Morty',
          status: CharacterStatus.alive,
          imageUrl: '',
        ),
      ];

      final firstResponse = AddCharactersByPageUseCaseResult(
        result: CharactersListEntity(
          count: 2,
          results: firstPageCharacters,
          next: 2,
        ),
        isLastPage: false,
      );

      final secondResponse = AddCharactersByPageUseCaseResult(
        result: CharactersListEntity(
          count: 2,
          results: [...firstPageCharacters, ...secondPageCharacters],
          next: null,
        ),
        isLastPage: true,
      );

      int callCount = 0;

      when(() => mockUseCase.call(any())).thenAnswer((_) async {
        if (callCount == 0) {
          callCount++;
          return Right(firstResponse);
        } else {
          return Right(secondResponse);
        }
      });

      final notifier = container.read(charactersViewModelProvider.notifier);

      // Act: primera página
      await notifier.fetchCharacters();

      // Assert estado después de la primera carga
      var state = container.read(charactersViewModelProvider);
      expect(state.characters, firstPageCharacters);
      expect(state.isLastPage, false);
      expect(state.nextPage, 2);

      // Act: segunda página
      await notifier.fetchCharacters();

      // Assert estado final acumulado
      state = container.read(charactersViewModelProvider);
      expect(state.characters, [
        ...firstPageCharacters,
        ...secondPageCharacters,
      ]);
      expect(state.isLastPage, true);
    });

    test('fetchCharacters sets error state when use case fails', () async {
      when(() => mockUseCase.call(any())).thenAnswer(
        (_) async => Left(GraphQLErrorException(message: 'API failed')),
      );

      final notifier = container.read(charactersViewModelProvider.notifier);

      await notifier.fetchCharacters();

      final state = container.read(charactersViewModelProvider);
      expect(state.status, FetchStatus.error);
      expect(state.errorMessage, 'API failed');
    });

    test(
      'fetchCharacters still calls useCase even when isLastPage is true (use case controls logic)',
      () async {
        final characters = [
          CharacterEntity(
            id: '1',
            name: 'Rick',
            status: CharacterStatus.alive,
            imageUrl: '',
          ),
        ];

        final response = AddCharactersByPageUseCaseResult(
          result: CharactersListEntity(results: characters, next: null),
          isLastPage: true,
        );

        when(
          () => mockUseCase.call(any()),
        ).thenAnswer((_) async => Right(response));

        final notifier = container.read(charactersViewModelProvider.notifier);

        await notifier.fetchCharacters();
        final state1 = container.read(charactersViewModelProvider);

        await notifier
            .fetchCharacters(); // aunque ya esLastPage, se vuelve a llamar
        final state2 = container.read(charactersViewModelProvider);

        verify(() => mockUseCase.call(any())).called(2);
        expect(state2.characters, state1.characters);
        expect(state2.isLastPage, true);
      },
    );
  });
}
