import 'package:posts/models/post.dart';

abstract class CreatePostRepository
{
    Future<Post> createPost(Map data);
}