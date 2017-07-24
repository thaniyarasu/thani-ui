import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:thani_ui/models/post.dart';
import 'package:thani_ui/services/post.dart';

@Component(
    selector: 'my-post-detail',
    templateUrl: 'show.html',
    styleUrls: const ['show.css'])
class PostDetailComponent implements OnInit {
  Post post;
  final PostService _postService;
  final RouteParams _routeParams;

  PostDetailComponent(this._postService, this._routeParams);

  Future<Null> ngOnInit() async {
    var idString = _routeParams.get('id');
    var id = int.parse(idString, onError: (_) => null);
    if (id != null) post = await (_postService.getPost(id));
  }

  Future<Null> save() async {
    await _postService.save(post);
    goBack();
  }

  void goBack() {
    window.history.back();
  }
}
