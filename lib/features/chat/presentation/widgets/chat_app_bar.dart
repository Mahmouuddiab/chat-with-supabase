import 'package:flutter/material.dart';
import '../cubit/chat_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String receiverName;
  final ChatCubit cubit;

  const ChatAppBar({
    super.key,
    required this.receiverName,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.deepPurple),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(receiverName),
              StreamBuilder<bool>(
                stream: cubit.onlineStream,
                builder: (context, snapshot) {
                  final isOnline = snapshot.data ?? false;

                  return Text(
                    isOnline ? "Online" : "Offline",
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}