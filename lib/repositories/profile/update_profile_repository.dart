
import 'package:posts/models/profile.dart';

abstract class UpdateProfileRepository {
  Future<void> updateProfile(Profile profile);
}