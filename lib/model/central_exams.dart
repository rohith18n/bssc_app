class CentralExam {
  final int id;
  final int parentCategoryId;
  final String name;
  final String slug;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CentralExamClasses> classes;

  CentralExam({
    required this.id,
    required this.parentCategoryId,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.classes,
  });

  factory CentralExam.fromJson(Map<String, dynamic> json) {
    return CentralExam(
      id: json['id'] as int,
      parentCategoryId: json['parent_category_id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      status: json['status'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      classes: (json['classes'] as List<dynamic>)
          .map((classData) => CentralExamClasses.fromJson(classData))
          .toList(),
    );
  }
}

class CentralExamClasses {
  final String name;
  final String url;

  CentralExamClasses({
    required this.name,
    required this.url,
  });

  factory CentralExamClasses.fromJson(Map<String, dynamic> json) {
    return CentralExamClasses(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
