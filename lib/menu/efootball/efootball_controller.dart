import 'package:get/get.dart';
import 'efootball_model.dart';
import 'efootball_service.dart';
import 'package:pas_mobile_11pplg1_10/database/database_helper.dart';

class AnimeController extends GetxController {
  var isLoading = false.obs;
  var postList = <PostModel>[].obs;
  var favoriteIds = <int>[].obs;

  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    fetchPosts();
    loadFavorites();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      var posts = await AnimeService.fetchPosts();
      postList.assignAll(posts);
    } catch (e) {
      print('Error while getting data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadFavorites() async {
    try {
      final ids = await dbHelper.getFavoriteIds();
      favoriteIds.assignAll(ids);
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  bool isFavorite(PostModel anime) {
    return favoriteIds.contains(anime.idTeam);
  }

  Future<void> toggleFavorite(PostModel anime) async {
    if (isFavorite(anime)) {
      // Remove from favorites
      await dbHelper.removeFavorite(anime.idTeam);
      favoriteIds.remove(anime.idTeam);
    } else {
      // Add to favorites
      await dbHelper.addFavorite(anime);
      favoriteIds.add(anime.idTeam);
    }
  }
}
