import 'package:omni_challenge/core/core.dart';

class CharactersListEntity {
  num? count;
  num? next;
  num? prev;
  List<CharacterEntity>? results;

  CharactersListEntity({this.count, this.next, this.prev, this.results});

  factory CharactersListEntity.fromModel(CharactersListModel model) =>
      CharactersListEntity(
        count: model.count,
        next: model.next,
        prev: model.prev,
        results:
            model.results?.map((x) => CharacterEntity.fromModel(x)).toList(),
      );
}
