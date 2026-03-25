import 'package:equatable/equatable.dart';
import 'package:supa_chat/features/chat/domain/entity/message_etity.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class OnlineStatusUpdated extends ChatState {
  final bool isOnline;

  const OnlineStatusUpdated(this.isOnline);

  @override
  List<Object?> get props => [isOnline];
}