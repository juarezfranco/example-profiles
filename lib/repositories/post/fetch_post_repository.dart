
import 'package:posts/models/post.dart';

abstract class FetchPostRepository {
  Future<List<Post>> fetchPost();
}