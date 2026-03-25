import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supa_chat/core/di/di.dart';
import 'package:supa_chat/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chat_screen.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  final supabase = Supabase.instance.client;

  late String myId;

  @override
  void initState() {
    super.initState();
    myId = supabase.auth.currentUser!.id;
  }

  /// ✅ Fetch users (you can later replace with chats table)
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await supabase
        .from('profiles') // 👈 your users table
        .select();

    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        backgroundColor: Colors.deepPurple,
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              /// ❌ Skip yourself
              if (user['id'] == myId) {
                return const SizedBox();
              }

              return _userTile(context, user);
            },
          );
        },
      ),
    );
  }

  /// 👤 User Tile
  Widget _userTile(BuildContext context, Map<String, dynamic> user) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),

      title: Text(user['name'] ?? 'No Name'),

      subtitle: const Text("Tap to chat"),

      trailing: const Icon(Icons.chat, color: Colors.deepPurple),

      /// 🔥 THIS is where Navigator.push is used
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<ChatCubit>(),
              child: ChatScreen(
                receiverId: user['id'],
                receiverName: user['name'] ?? 'User',
              ),
            ),
          ),
        );
      },
    );
  }
}