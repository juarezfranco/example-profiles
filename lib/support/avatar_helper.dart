import 'dart:math';

import 'package:posts/enums/avatar_enums.dart';

class AvatarHelper {
  String generateUrlAvatar() {
    String url = "https://avataaars.io?";
    final rand = Random();

    List enums = [
      avatarStyle.values[rand.nextInt(avatarStyle.values.length - 1)],
      skinColor.values[rand.nextInt(skinColor.values.length - 1)],
      mouthType.values[rand.nextInt(mouthType.values.length - 1)],
      eyebrowType.values[rand.nextInt(eyebrowType.values.length - 1)],
      eyeType.values[rand.nextInt(eyeType.values.length - 1)],
      clotheType.values[rand.nextInt(clotheType.values.length - 1)],
      clotheColor.values[rand.nextInt(clotheColor.values.length - 1)],
      graphicType.values[rand.nextInt(graphicType.values.length - 1)],
      facialHairType.values[rand.nextInt(facialHairType.values.length - 1)],
      facialHairColor.values[rand.nextInt(facialHairColor.values.length - 1)],
      hairColor.values[rand.nextInt(hairColor.values.length - 1)],
      hatColor.values[rand.nextInt(hatColor.values.length - 1)],
      accessoriesType.values[rand.nextInt(accessoriesType.values.length - 1)],
      topType.values[rand.nextInt(topType.values.length - 1)],
    ];
    List<String> params = [];
    for (var el in enums) {
      el = el.toString();

      final key = (el.split(".")[0] as String);
      final value = (el.split(".")[1] as String);

      params.add("$key=$value");
    }
    return url + params.join("&");
  }
}