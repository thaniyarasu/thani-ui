class Post {
  final int id;
  String name;

  Post(this.id, this.name);

  factory Post.fromJson(Map<String, dynamic> post) =>
      new Post(_toInt(post['id']), post['name']);

  Map toJson() => {'id': id, 'name': name};
}

int _toInt(id) => id is int ? id : int.parse(id);
