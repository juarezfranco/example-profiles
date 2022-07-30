import 'package:localstore/localstore.dart';
import 'package:posts/config/localstore_config.dart';
import 'package:posts/models/profile.dart';
import 'package:posts/repositories/profile/create_profile_repository.dart';
import 'package:posts/repositories/profile/update_profile_repository.dart';

class UpdateProfileLocalstore implements UpdateProfileRepository {

  final Localstore db;

  const UpdateProfileLocalstore({
    required this.db,
  });

  @override
  Future<void> updateProfile(Profile profile) async {
    final collection = db.collection(LocalstoreConfig.profileCollection);
    final result = await collection.get();

    for(MapEntry entry in result!.entries) {
      if (entry.value["id"] == profile.id) {
        final id = (entry.key as String).split("/")[2];
        await collection.doc(id).set(profile.toMap());
        return;
      }
    }
  }

}