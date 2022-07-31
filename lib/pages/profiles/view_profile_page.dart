import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posts/models/profile.dart';
import 'package:posts/pages/profiles/edit_profile_page.dart';
import 'package:posts/repositories/profile/fetch_profile_repository.dart';
import 'package:posts/support/app_container.dart';

class ViewProfilePage extends StatefulWidget {
  final Profile profile;

  const ViewProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  var _fetchProfile = false;
  late Profile profile;

  @override
  void initState() {
    super.initState();
    profile = widget.profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          if (profile.logged)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final response = await Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => EditProfilePage(
                      profile: profile,
                    ),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
                if (response == "has_updated") {
                  setState(() => _fetchProfile = true);
                }
              },
            ),
        ],
      ),
      body: ! _fetchProfile
          ? _ViewProfile(
              profile,
            )
          : FutureBuilder<Profile>(
              future: AppContainer.resolve<FetchProfileRepository>()
                  .fetchProfileById(profile.id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: TextButton(
                          onPressed: () => setState(() => {}),
                          child: const Text("Unable to load data"),
                        ),
                      );
                    }
                    profile = snapshot.data!;

                    return _ViewProfile(profile);
                }
              },
            ),
    );
  }
}

class _ViewProfile extends StatelessWidget {
  final Profile profile;

  const _ViewProfile(this.profile);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Hero(
                tag: profile.id,
                child: SvgPicture.network(profile.photo),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            profile.name,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            profile.email ?? "",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            profile.phone ?? "",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
