import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:thani_ui/models/post.dart';

@Injectable()
class PostService {
  static final _headers = {'Content-Type': 'application/json'};
  //static const _apiUrl = "http://localhost:3000/api/posts";
  static const _apiUrl = "/api/posts";
  // URL to web API

  final BrowserClient _http;

  PostService(this._http);

  Future<List<Post>> getPosts() async {
    try {
      final response = await _http.get(_apiUrl + '.json');
      final posts = _extractData(response)
          .map((value) => new Post.fromJson(value))
          .toList();
      return posts;
      } catch (e) {
        throw _handleError(e);
     }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body);

  /*
    Future<Post> getPost(int id) async =>
      (await getPosts()).firstWhere((post) => post.id == id);
  */
  
  Future<Post> getPost(int id) async {
    try {
      final response = await _http.get(_apiUrl + '/${id}.json');
      final post = new Post.fromJson(_extractData(response));
//          .map((value) => new Post.fromJson(value));
      return post;
    } catch (e) {
        throw _handleError(e);
    }
  }

  Future<Post> save(dynamic postOrName) =>
      postOrName is Post ? _put(postOrName) : _post(postOrName);

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }

  Future<Post> _post(String name) async {
    try {
      final response = await _http.post(_apiUrl + '.json',
          headers: _headers, body: JSON.encode({'name': name}));
      return new Post.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Post> _put(Post post) async {
    try {
      var url = _apiUrl + '/${post.id}.json';
      final response =
          await _http.put(url, headers: _headers, body: JSON.encode(post));
      return new Post.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Null> delete(int id) async {
    try {
      var url = _apiUrl + '/${id}.json';
      await _http.delete(url, headers: _headers);
    } catch (e) {
      throw _handleError(e);
    }
  }
}
