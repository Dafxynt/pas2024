import 'package:pas_mobile_11pplg1_10/bottom_nav.dart';

import 'efootball_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '';

class efootballView extends StatelessWidget {
  final AnimeController animeController = Get.put(AnimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Efootball List'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (animeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (animeController.postList.isEmpty) {
          return const Center(child: Text('No Data Available'));
        }
        return ListView.builder(
          itemCount: animeController.postList.length,
          itemBuilder: (context, index) {
            final post = animeController.postList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: Image.network(
                  post.strLogo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(post.strTeam),
                subtitle: Text(post.strLeague),
                trailing: Obx(() {
                  return IconButton(
                    icon: Icon(
                      animeController.isFavorite(post)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: animeController.isFavorite(post)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () async {
                      await animeController.toggleFavorite(post);

                      // Tampilkan Snackbar
                      final message = animeController.isFavorite(post)
                          ? '${post.strTeam} added to favorites'
                          : '${post.strLogo} removed from favorites';
                      Get.snackbar(
                        'Success',
                        message,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        duration: const Duration(seconds: 2),
                      );
                    },
                  );
                }),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
