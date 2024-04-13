class StateExam {
  final int id;
  final int parentCategoryId;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<StateExamItem> stateExamItems;

  StateExam({
    required this.id,
    required this.parentCategoryId,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.stateExamItems,
  });

  factory StateExam.fromJson(Map<String, dynamic> json) {
    final List<dynamic> stateExamItemList = json['state_exam'];
    final stateExamItems = stateExamItemList
        .map((itemData) => StateExamItem.fromJson(itemData))
        .toList();

    return StateExam(
      id: json['id'],
      parentCategoryId: json['parent_category_id'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      stateExamItems: stateExamItems,
    );
  }

  @override
  String toString() {
    return 'StateExam(id: $id, parentCategoryId: $parentCategoryId, name: $name, slug: $slug, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, stateExamItems: $stateExamItems)';
  }
}

class StateExamItem {
  final int id;
  final String name;
  final String slug;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<StateExamClass> classes;

  StateExamItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.classes,
  });

  factory StateExamItem.fromJson(Map<String, dynamic> json) {
    final List<dynamic> classList = json['classes'];
    final classes = classList
        .map((classData) => StateExamClass.fromJson(classData))
        .toList();

    return StateExamItem(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      classes: classes,
    );
  }

  @override
  String toString() {
    return 'StateExamItem(id: $id, name: $name, slug: $slug, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, classes: $classes)';
  }
}

class StateExamClass {
  final String name;
  final String url;

  StateExamClass({
    required this.name,
    required this.url,
  });

  factory StateExamClass.fromJson(Map<String, dynamic> json) {
    return StateExamClass(
      name: json['name'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    return 'StateExamClass(name: $name, url: $url)';
  }
}
