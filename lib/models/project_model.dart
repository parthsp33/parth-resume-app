class ProjectModel {
  final String name;
  final String shortDescription;
  final String status;
  final String tools;
  final List<String> keyFeatures;
  final int teamSize;
  final String? appStoreLink;
  final String? playStoreLink;

  ProjectModel({
    required this.name,
    required this.shortDescription,
    required this.status,
    required this.tools,
    required this.keyFeatures,
    required this.teamSize,
    this.appStoreLink,
    this.playStoreLink,
  });
}
