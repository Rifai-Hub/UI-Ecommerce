import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_ecommerce/chat/detail_chat.dart';

// ✅ Data daftar chat
final List<Map<String, String>> chats = [
  {
    'name': 'Nike Official',
    'message': 'Hallo, Selamat Datang Di Nike Official.',
    'time': '12:30',
    'avatar': 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Logo_NIKE.svg/800px-Logo_NIKE.svg.png',
  },
  {
    'name': 'Foot Locker',
    'message': 'Segera Check Out Biar Ga Ketinggalan Promonya!',
    'time': '12:05',
    'avatar': 'https://logos-world.net/wp-content/uploads/2020/11/Foot-Locker-Logo.png',
  },
  {
    'name': 'Customer Service',
    'message': 'Ada yang bisa kami bantu?',
    'time': '10:15',
    'avatar': 'https://picsum.photos/100/100?random=3', // Contoh avatar customer service
  },
];

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFEDECF2),
      body: Column(
        children: [
          // Custom AppBar dengan gradien
          _buildCustomAppBar(context),

          // Tombol Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Semua',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF0095DA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Belum Dibaca',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List Chat dengan tampilan card
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return _buildChatCard(context, chat, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0095DA), Color(0xFF5EBEF3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'List Chat',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildChatCard(BuildContext context, Map<String, String> chat, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chat['avatar']!),
          radius: 25,
        ),
        title: Text(
          chat['name']!,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          chat['message']!,
          style: GoogleFonts.poppins(color: Colors.grey[600]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['time']!,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            if (index == 0) // Contoh jika ada pesan belum dibaca
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '1',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                contactName: chat['name']!,
                avatarAsset: chat['avatar']!,
              ),
            ),
          );
        },
      ),
    );
  }
}