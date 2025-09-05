import 'package:flutter/material.dart';

// ✅ Data daftar chat
final List<Map<String, String>> chats = [
  {
    'name': 'Nike Official',
    'message': 'Hallo, Selamat Datang Di Nike Official.',
    'time': '12:30',
    // ✅ Logo Nike PNG (langsung bisa tampil)
    'avatar':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Logo_NIKE.svg/800px-Logo_NIKE.svg.png',
  },
  {
    'name': 'Foot Locker',
    'message': 'Segera Check Out Biar Ga Ketinggalan Promonya!',
    'time': '12:05',
    // ✅ Ganti link Foot Locker ke PNG (bukan SVG)
    'avatar':
        'https://logos-world.net/wp-content/uploads/2020/11/Foot-Locker-Logo.png',
  },
];

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Tambahkan AppBar dan Tombol Pencarian
      appBar: AppBar(
        title: const Text(
          'List Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF4C53A5),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),

      body: Column(
        children: [
          // ✅ Tambahkan Tombol Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Semua',
                    style: TextStyle(
                      color: Color(0xFF4C53A5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Belum Dibaca',
                    style: TextStyle(
                      color: Color.fromARGB(255, 114, 123, 216),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ✅ Tampilkan List Chat dengan ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    // ✅ Ubah dari AssetImage ke NetworkImage
                    backgroundImage: NetworkImage(chat['avatar']!),
                    radius: 25,
                  ),
                  title: Text(
                    chat['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(chat['message']!),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat['time']!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      if (index == 0) // ✅ contoh jika ada pesan belum dibaca
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'ChatDetail',
                      arguments: {
                        'contactName': chat['name'],
                        'avatarAsset': chat['avatar'], // ✅ Tambahan: kirim avatar ke ChatScreen
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
