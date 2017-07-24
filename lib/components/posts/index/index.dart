import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:thani_ui/models/post.dart';
import 'package:thani_ui/components/posts/show/show.dart';
import 'package:thani_ui/services/post.dart';

@Component(
    selector: 'my-posts',
    templateUrl: 'index.html',
    styleUrls: const ['index.css'],
    directives: const [PostDetailComponent])

class PostsComponent implements OnInit {
  final Router _router;
  final PostService _postService;
  List<Post> posts;
  Post selectedPost;
  String errorMessage;

  PostsComponent(this._postService, this._router);

  Future<Null> addPost(String name) async {
    name = name.trim();
    if (name.isEmpty) return;
    try {
      posts.add(await _postService.save(name));
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<Null> deletePost(int id, event) async {
    try {
      event.stopPropagation();
      await _postService.delete(id);

      posts.removeWhere((post) => post.id == id);
      if (selectedPost?.id == id) selectedPost = null;
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<Null> getPosts() async {
    posts = await _postService.getPosts();
  }

  void ngOnInit() {
    getPosts();
  }

  void onSelect(Post post) {
    selectedPost = post;
  }

  Future<Null> gotoDetail() => _router.navigate([
        'PostDetail',
        {'id': selectedPost.id.toString()}
      ]);
}
