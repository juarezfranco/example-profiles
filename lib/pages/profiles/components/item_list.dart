import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posts/models/profile.dart';
import 'package:posts/pages/profiles/view_profile_page.dart';

class ItemList extends StatelessWidget {
  final Profile profile;
  final VoidCallback onItemPressed;

  const ItemList({
    super.key,
    required this.profile,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Hero(
                tag: profile.id,
                child: SvgPicture.network(profile.photo),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          ],
        ),
      ),
    );
  }
}
