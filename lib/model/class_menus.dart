class SchoolClass {
  final int id;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<Class> classes;

  SchoolClass({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.classes,
  });

  factory SchoolClass.fromJson(Map<String, dynamic> json) {
    var classList = json['classes'] as List;
    List<Class> classes =
        classList.map((json) => Class.fromJson(json)).toList();

    return SchoolClass(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      classes: classes,
    );
  }
}

class Class {
  final String name;
  final String url;

  Class({
    required this.name,
    required this.url,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      name: json['name'],
      url: json['url'],
    );
  }
}
