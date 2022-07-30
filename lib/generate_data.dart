import 'package:posts/models/profile.dart';
import 'package:posts/repositories/profile/create_profile_repository.dart';
import 'package:posts/repositories/profile/delete_all_profiles_repository.dart';
import 'package:posts/repositories/profile/fetch_profile_repository.dart';
import 'package:posts/support/app_container.dart';
import 'package:posts/support/avatar_helper.dart';

class GenerateFakeData {
  Future<void> generate({
    bool reset = false,
  }) async {
    final fetchProfilesRepo = AppContainer.resolve<FetchProfileRepository>();
    final createProfileRepo = AppContainer.resolve<CreateProfileRepository>();
    final deleteProfilesRepo =
        AppContainer.resolve<DeleteAllProfilesRepository>();

    if (reset) {
      await deleteProfilesRepo.deleteAllProfiles();
      await Future.delayed(const Duration(milliseconds: 250));
    }

    final profiles = await fetchProfilesRepo.fetchProfiles();

    if (profiles.isEmpty) {
      await createProfileRepo.createProfile(
        Profile(
          name: "You",
          photo: AvatarHelper().generateUrlAvatar(),
          phone: "",
          email: "",
          logged: true,
        ),
      );

      for (var i in [1, 2, 3, 4, 5, 6, 7, 8, 9]) {
        await createProfileRepo.createProfile(
          Profile(
            name: "Profile $i",
            photo: AvatarHelper().generateUrlAvatar(),
            phone: "(9$i$i) 9$i$i$i-$i$i$i$i",
            email: "profile$i@mail.com",
          ),
        );
      }
    }
  }
}
