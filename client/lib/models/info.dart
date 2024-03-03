class Info {
  String state;
  String file;
  String title;
  String author;

  Info({
    this.state = '',
    this.file = '',
    this.title = '',
    this.author = '',
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('State')) {
      return Info(
        state: json['State'],
        file: json['File'] ?? '',
        title: json['Title'] ?? '',
        author: json['Author'] ?? '',
      );
    }

    throw FormatException('Failed to load info.');
  }
}
