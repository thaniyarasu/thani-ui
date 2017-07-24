import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:stream_transformers/stream_transformers.dart';

import 'package:thani_ui/services/post_search.dart';
import 'package:thani_ui/models/post.dart';

@Component(
    selector: 'post-search',
    templateUrl: 'search.html',
    styleUrls: const ['search.css'],
    providers: const [PostSearchService])

class PostSearchComponent implements OnInit {
  PostSearchService _postSearchService;
  Router _router;

  Stream<List<Post>> posts;
  StreamController<String> _searchTerms =
      new StreamController<String>.broadcast();

  PostSearchComponent(this._postSearchService, this._router) {}

  // Push a search term into the stream.
  void search(String term) => _searchTerms.add(term);

  Future<Null> ngOnInit() async {
    posts = _searchTerms.stream
        .transform(new Debounce(new Duration(milliseconds: 300)))
        .distinct()
        .transform(new FlatMapLatest((term) => term.isEmpty
            ? new Stream<List<Post>>.fromIterable([<Post>[]])
            : _postSearchService.search(term).asStream()))
        .handleError((e) {
      print(e); // for demo purposes only
    });
  }

  void gotoDetail(Post post) {
    var link = [
      'PostDetail',
      {'id': post.id.toString()}
    ];
    _router.navigate(link);
  }
}
