import 'package:omni_challenge/core/core.dart';

final graphqlProvider = Provider<GraphQLService>(
  (ref) => GraphQLServiceImpl(
    baseUrl: String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://rickandmortyapi.com/graphql',
    ),
  ),
);
