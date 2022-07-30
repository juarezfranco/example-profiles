import 'package:localstore/localstore.dart';
import 'package:posts/config/localstore_config.dart';
import 'package:posts/repositories/profile/delete_all_profiles_repository.dart';

class DeleteAllProfilesLocalstore implements DeleteAllProfilesRepository {
  final Localstore db;

  const DeleteAllProfilesLocalstore({
    required this.db,
  });

  @override
  Future<void> deleteAllProfiles() async {
    final collection = db.collection(LocalstoreConfig.profileCollection);
    final result = await collection.get();

    if (result == null) {
      return;
    }

    for(MapEntry entry in result.entries) {
      final id = (entry.key as String).split("/")[2];
      await collection.doc(id).delete();
    }
  }

}