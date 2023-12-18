import '../../../core/app_export.dart';

/// This class is used in the [favorites_item_widget] screen.
class FavoritesItemModel {
  FavoritesItemModel({
    this.tracks,
    this.addToPlaylist,
    this.id,
  }) {
    tracks = tracks ?? ImageConstant.imgMusic;
    addToPlaylist = addToPlaylist ?? "Tracks";
    id = id ?? "";
  }

  String? tracks;

  String? addToPlaylist;

  String? id;
}
