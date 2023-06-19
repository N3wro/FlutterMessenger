//Falls eine Textnachricht mehrere Attribute bekommen sollte, bitte diese Klasse hier verwenden
class Message {
  String? id;
  String _content;

  Message(this._content, [String? _id]);

  String get content => _content;

  Message.fromJson(String id, Map<String, dynamic> json)
      : this(json['content'], id);

  Map<String, dynamic> toJson() {
    return {
      "content": _content,
    };
  }
}
