import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:thani_ui/models/post.dart';
import 'package:thani_ui/services/post.dart';
import 'package:thani_ui/components/posts/search/search.dart';

@Component(
    selector: 'my-dashboard',
    templateUrl: 'dashboard.html',
    styleUrls: const ['dashboard.css'],
    directives: const [PostSearchComponent])

class DashboardComponent implements OnInit {
  List<Post> posts;

  final Router _router;
  final PostService _postService;

  DashboardComponent(this._postService, this._router);

  Future<Null> ngOnInit() async {
    posts = (await _postService.getPosts()).skip(1).take(4).toList();
  }

  void gotoDetail(Post post) {
    var link = [
      'PostDetail',
      {'id': post.id.toString()}
    ];
    _router.navigate(link);
  }
}
