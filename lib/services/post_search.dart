import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';
import 'package:thani_ui/models/post.dart';

@Injectable()
class PostSearchService {
  final BrowserClient _http;
  //static const _apiUrl = "http://localhost:3000/api/posts";
  static const _apiUrl = "/api/posts";
  PostSearchService(this._http);

  Future<List<Post>> search(String term) async {
    try {
      final response = await _http.get(_apiUrl+'.json');
      return _extractData(response)
          .map((json) => new Post.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body);

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }
}
