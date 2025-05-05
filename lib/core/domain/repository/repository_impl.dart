import 'package:omni_challenge/core/core.dart';

class RepositoryImpl extends IRepository {
  final IDataSource dataSource;

  RepositoryImpl({required this.dataSource});

  @override
  Future<Either<GraphQLErrorException, CharactersListEntity>> getCharacters({
    num page = 1,
  }) async {
    try {
      final result = await dataSource.getCharacters(page: page);
      return Right(CharactersListEntity.fromModel(result));
    } on GraphQLErrorException catch (e) {
      return Left(e);
    }
  }
}
