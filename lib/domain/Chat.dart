class Chat {
  String? id;
  String _title;

  String _image_url;
  Map<String, String>? _messages;
  String _description;

  Chat(this._messages, this._title, this._image_url, this._description,
      [this.id]);

  String get description => _description;

  String get title => _title;

  Map<String, String> get messages =>
      _messages == null ? Map<String, String>() : _messages!;

  String get image_url => _image_url;

  set title(String value) {
    _title = value;
  }

  Chat.fromJson(String id, Map<String, dynamic> json)
      : this(
            json['messages'] == null
                ? null
                : Map.from(json['messages'].map((key, value) {
                    return MapEntry(
                        key.toString(),
                        value.values
                            .toString()
                            .substring(1, value.values.toString().length - 1));
                  })),
            json['title'],
            json['image'],
            json['description'],
            id);

  Map<String, dynamic> toJsonMessage(String message) {
    return {"content": message};
  }

  Map<dynamic, dynamic> toJsonMessages(Map<String, String> messages) {
    return {
      _messages!.keys: {"content": messages.values},
    };
  }

  Map<String, dynamic> toJsonMessage_key(String key) {
    return {
      "key": key,
    };
  }

  Map<String, dynamic> toJson() {
    return {"description": description, "image": image_url, "title": _title};
  }

  set image_url(String value) {
    _image_url = value;
  }

  set messages(Map<String, String> value) {
    _messages = value;
  }

  set description(String value) {
    _description = value;
  }
}
