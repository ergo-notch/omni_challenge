import '../../core.dart';

final dataSourceProvider = Provider<IDataSource>(
  (ref) => DataSourceImpl(client: ref.read(graphqlProvider)),
);

abstract class IDataSource {
  Future<CharactersListModel> getCharacters({num page = 1});
}

class DataSourceImpl implements IDataSource {
  final GraphQLService client;

  DataSourceImpl({required this.client});

  @override
  Future<CharactersListModel> getCharacters({num page = 1}) async {
    try {
      final result = await client.query('''
                    query {
                      characters(page: $page) {
                            info{
                                  count
                                  next
                                  prev
                            }
                            results{
                                  id
                                  name
                                  status
                                  species
                                  image
                              }
                            }
                      }''');

      return CharactersListModel.fromJson(result);
    } on GraphQLErrorException catch (_) {
      rethrow;
    } catch (e) {
      throw GraphQLErrorException(message: 'Error fetching characters: $e');
    }
  }
}
