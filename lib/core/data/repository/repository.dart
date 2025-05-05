import 'package:omni_challenge/core/domain/repository/repository_impl.dart';

import '../../core.dart';

final repositoryProvider = Provider<IRepository>(
  (ref) => RepositoryImpl(dataSource: ref.read(dataSourceProvider)),
);

abstract class IRepository {
  Future<Either<GraphQLErrorException, CharactersListEntity>> getCharacters({
    num page = 1,
  });
}
