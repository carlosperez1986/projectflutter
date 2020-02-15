class Chat
{
    final int id;
    final DateTime date;
    final String userName;
    final String photo;

    Chat(this.id, this.date, this.userName, this.photo);

    Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date=json['date'],
        photo=json['photo'],
        userName = json['userName'];

    Map<String, dynamic> toJson() =>
    {
      'id': id,
      'date': date,
      'photo':photo,
      'userName':userName
    };
}

class ChatList {
  final List<Chat> chatList;

  ChatList({
    this.chatList,
  });
  
}