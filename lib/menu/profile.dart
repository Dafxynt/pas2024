import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_10/login/logContoller.dart';
import '../bottom_nav.dart';

class Profile extends StatelessWidget {
  final LogController logController = Get.find<LogController>(); // Dapatkan controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bagian header dengan avatar
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/019/879/198/small_2x/user-icon-on-transparent-background-free-png.png', // Ganti URL gambar sesuai kebutuhan
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              // Gunakan loggedInUsername dari LogController
              return Text(
                logController.loggedInUsername.value, // Nama pengguna
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            const SizedBox(height: 20),

            // Informasi pengguna dalam bentuk kartu
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hello! I am a Flutter developer passionate about building modern and responsive apps.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Tombol logout dengan konfirmasi
            ElevatedButton.icon(
              onPressed: () {
                // Tampilkan dialog konfirmasi
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
