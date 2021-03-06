class Title {
  String raw;
  String rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['raw'] = this.raw;
    data['rendered'] = this.rendered;

    return data;
  }
}
