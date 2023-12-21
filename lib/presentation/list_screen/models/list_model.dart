// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import 'songlist_item_model.dart';

/// This class defines the variables used in the [list_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ListModel extends Equatable {
  ListModel({this.songlistItemList = const []}) {}

  List<SonglistItemModel> songlistItemList;

  ListModel copyWith({List<SonglistItemModel>? songlistItemList}) {
    return ListModel(
      songlistItemList: songlistItemList ?? this.songlistItemList,
    );
  }

  @override
  List<Object?> get props => [songlistItemList];
}
