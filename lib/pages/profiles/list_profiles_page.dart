import 'package:flutter/material.dart';
import 'package:posts/models/profile.dart';
import 'package:posts/pages/profiles/components/item_list.dart';
import 'package:posts/pages/profiles/view_profile_page.dart';
import 'package:posts/repositories/profile/fetch_profile_repository.dart';
import 'package:posts/support/app_container.dart';

class ListProfilesPage extends StatefulWidget {
  const ListProfilesPage({super.key});

  @override
  State<ListProfilesPage> createState() => _ListProfilesPageState();
}

class _ListProfilesPageState extends State<ListProfilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profiles"),
      ),
      body: FutureBuilder<List<Profile>>(
        future: AppContainer.resolve<FetchProfileRepository>().fetchProfiles(),
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

              final profiles = snapshot.data!;

              return ListView(
                children: profiles
                    .map<Widget>(
                      (profile) => ItemList(
                        profile: profile,
                        onItemPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewProfilePage(profile: profile),
                            ),
                          );
                          if (profile.logged) {
                            setState(() => {});
                          }
                        },
                      ),
                    )
                    .toList(),
              );
              break;
          }
        },
      ),
    );
  }
}
