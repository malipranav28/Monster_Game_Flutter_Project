class Environment {
  final String name;
  final String filePath;
  final bool? isLocked;

  const Environment({
    required this.filePath,
    required this.name,
    this.isLocked,
  });
}
