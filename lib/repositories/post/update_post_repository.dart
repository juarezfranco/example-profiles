
import 'package:posts/models/post.dart';

abstract class UpdatePostRepository {
  Future<void> updatePost(Post post, Map newData);
}