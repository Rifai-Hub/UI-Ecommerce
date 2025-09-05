import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String avatarAsset; // ✅ Tambahan: supaya AppBar bisa pakai avatar juga

  const ChatScreen({
    required this.contactName,
    required this.avatarAsset, // ✅ Tambahan
    super.key,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ✅ Siapkan Data Pesan dan Controller
  List<Map<String, dynamic>> messages = [
    {'text': 'Hallo', 'isMe': true, 'time': '12:55'},
    {'text': 'Ada yang bisa dibantu?', 'isMe': false, 'time': '13:00'},
  ];

  final TextEditingController _controller = TextEditingController();

  // ✅ Buat Fungsi Kirim Pesan
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _controller.text,
          'isMe': true,
          // ✅ Ubah jadi waktu otomatis
          'time':
              "${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}",
        });
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Ubah AppBar → Tambahkan avatar & nama
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.avatarAsset), // ✅ Avatar toko
              radius: 18,
            ),
            const SizedBox(width: 10),
            Text(
              widget.contactName,
              style: const TextStyle(
                color: Color(0xFF4C53A5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
      ),

      body: Column(
        children: [
          // ✅ Tampilkan Pesan dengan ListView
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - index - 1];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Align(
                    alignment: message['isMe']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: message['isMe']
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            // ✅ Warna berbeda untuk pesan masuk & keluar
                            color: message['isMe']
                                ? const Color(0xFF4C53A5)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message['text'],
                            style: TextStyle(
                              fontSize: 16,
                              color: message['isMe']
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // ✅ Waktu pesan
                        Text(
                          message['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // ✅ Tambahkan Input dan Tombol Kirim lebih menarik
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // ✅ Tambah ikon emoji
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined,
                      color: Color(0xFF4C53A5)),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // ✅ Tombol kirim dengan background bulat
                CircleAvatar(
                  backgroundColor: const Color(0xFF4C53A5),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
