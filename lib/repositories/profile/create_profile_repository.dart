import 'package:posts/models/profile.dart';

abstract class CreateProfileRepository {
  Future<void> createProfile(Profile profile);
}