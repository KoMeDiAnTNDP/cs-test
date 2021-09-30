class NavigateBodyAction {
  final String path;
  final String title;
  NavigateBodyAction(this.path, this.title);

  @override
  toString() => 'NavigateBodyAction{path: $path, title: $title}';
}

class NavigateRootAction {
  final String path;
  NavigateRootAction(this.path);

  @override
  toString() => 'NavigateRootAction{path: $path}';
}
