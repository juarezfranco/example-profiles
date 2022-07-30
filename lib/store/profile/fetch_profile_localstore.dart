import 'package:posts/config/localstore_config.dart';
import 'package:posts/models/profile.dart';
import 'package:localstore/localstore.dart';
import 'package:posts/repositories/profile/fetch_profile_repository.dart';

class FetchProfileLocalstore implements FetchProfileRepository {
  final Localstore db;

  const FetchProfileLocalstore({
    required this.db,
  });

  @override
  Future<List<Profile>> fetchProfiles() async {
    final collection = db.collection(LocalstoreConfig.profileCollection);
    final result = await collection.get();

    if (result == null || result.isEmpty == true) {
      return [];
    }

    final profiles = result.values
        .map<Profile>((element) => Profile.fromMap(element))
        .toList();

    profiles.sort((a, b) => a.name.compareTo(b.name));

    return profiles;
  }

  @override
  Future<Profile> fetchProfileById(String id) async {
    final collection = db.collection(LocalstoreConfig.profileCollection);
    final result = await collection.get();
    final item = result!.values.firstWhere((el) => el["id"] == id);
    return Profile.fromMap(item);
  }
}
