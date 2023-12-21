/// This class is used in the [songlist_item_widget] screen.
class SonglistItemModel {
  SonglistItemModel({
    this.songNumber,
    this.burning,
    this.podvalCaplella,
    this.id,
  }) {
    songNumber = songNumber ?? "1";
    burning = burning ?? "Burning";
    podvalCaplella = podvalCaplella ?? "Podval Caplella";
    id = id ?? "";
  }

  String? songNumber;

  String? burning;

  String? podvalCaplella;

  String? id;
}
