
import 'package:posts/models/profile.dart';

abstract class FetchProfileRepository {
  Future<Profile> fetchProfileById(String id);

  Future<List<Profile>> fetchProfiles();
}