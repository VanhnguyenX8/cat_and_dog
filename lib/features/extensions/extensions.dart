extension XUri on Uri {
  String get safeOrigin => (!['http', 'https'].contains(scheme) || host.isEmpty) ? '' : origin;
}

extension XString on String {
  String toDecapitalize() {
    if (isEmpty) {
      return this;
    }
    if (length == 1) {
      return toLowerCase();
    }
    return this[0].toLowerCase() + substring(1);
  }
}
