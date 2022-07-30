import 'package:kiwi/kiwi.dart';
import 'package:localstore/localstore.dart';
import 'package:posts/repositories/profile/create_profile_repository.dart';
import 'package:posts/repositories/profile/delete_all_profiles_repository.dart';
import 'package:posts/repositories/profile/fetch_profile_repository.dart';
import 'package:posts/repositories/profile/update_profile_repository.dart';
import 'package:posts/store/profile/create_profile_localstore.dart';
import 'package:posts/store/profile/delete_all_profiles_localstore.dart';
import 'package:posts/store/profile/fetch_profile_localstore.dart';
import 'package:posts/store/profile/update_profile_localstore.dart';

// wrap for KiwiContainer, concentrates operations here, because Kiwi can be replaced
class AppContainer {
  static initialize() {
    _registerRepositories();
  }

  static _registerRepositories() {
    final db = Localstore.instance;

    registerFactory<FetchProfileRepository>(
      (container) => FetchProfileLocalstore(db: db),
    );
    registerFactory<CreateProfileRepository>(
      (container) => CreateProfileLocalstore(db: db),
    );
    registerFactory<UpdateProfileRepository>(
      (container) => UpdateProfileLocalstore(db: db),
    );
    registerFactory<DeleteAllProfilesRepository>(
      (container) => DeleteAllProfilesLocalstore(db: db),
    );
  }

  static T resolve<T>() {
    return KiwiContainer().resolve<T>();
  }

  static void registerFactory<S>(
    Factory<S> factory, {
    String? name,
  }) {
    KiwiContainer().registerFactory<S>(factory, name: name);
  }

  static void registerSingleton<S>(
    Factory<S> factory, {
    String? name,
  }) {
    KiwiContainer().registerSingleton<S>(factory, name: name);
  }
}
