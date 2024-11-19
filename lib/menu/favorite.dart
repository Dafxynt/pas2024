import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/database_helper.dart';
import '../menu/efootball/efootball_model.dart'; // Import model yang benar
import '../bottom_nav.dart'; // Import bottom nav

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<PostModel>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = DatabaseHelper.instance.getFavorites();
  }

  Future<void> _confirmDelete(PostModel anime) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete "${anime.strTeam}" from favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Tidak menghapus
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Konfirmasi menghapus
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (result == true) {
      await DatabaseHelper.instance.removeFavorite(anime.idTeam);
      Get.snackbar(
        'Deleted',
        '${anime.strTeam} removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      setState(() {
        _loadFavorites();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Anime', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<PostModel>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No favorite anime found.'));
            }

            final favorites = snapshot.data!;

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final anime = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Image.network(
                      anime.strLogo,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(anime.strTeam),
                    subtitle: Text(anime.strLeague),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDelete(anime),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}