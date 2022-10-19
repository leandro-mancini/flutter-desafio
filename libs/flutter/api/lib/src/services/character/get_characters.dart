import '../../constants.dart';
import '../../models/character.dart';
import '../entities/get_entities.dart';

class CharacterService extends GetEntitiesService {
  Future<List<Character>> getAllCharacters() async {
    List<Map<String, dynamic>> objects = await super
      .getAllEntities('${Constants.baseURL}${Constants.characterEndpoint}');

    return List<Character>.from(objects.map((x) => Character.fromJson(x)));
  }

  Future<Character> getCharacter(String id) async {
    dynamic objects = await super
      .getEntitie('${Constants.baseURL}${Constants.characterEndpoint}/$id');

    return Character.fromJson(objects);
  }
}