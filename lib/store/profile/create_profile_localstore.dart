import 'package:localstore/localstore.dart';
import 'package:posts/config/localstore_config.dart';
import 'package:posts/models/profile.dart';
import 'package:posts/repositories/profile/create_profile_repository.dart';

class CreateProfileLocalstore implements CreateProfileRepository {

  final Localstore db;

  const CreateProfileLocalstore({
    required this.db,
  });

  @override
  Future<void> createProfile(Profile profile) async {
    final collection = db.collection(LocalstoreConfig.profileCollection);
    final id = collection.doc().id;
    collection.doc(id).set(profile.toMap());
  }

}