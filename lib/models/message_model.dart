import 'package:chat/components/constants.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);
  factory MessageModel.fromJason(jsonData) {
    return MessageModel(jsonData[kMessag], jsonData['id']);
  }
}
