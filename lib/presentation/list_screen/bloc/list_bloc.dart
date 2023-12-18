import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/songlist_item_model.dart';
import 'package:chauhan_s_application1/presentation/list_screen/models/list_model.dart';
part 'list_event.dart';
part 'list_state.dart';

/// A bloc that manages the state of a List according to the event that is dispatched to it.
class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc(ListState initialState) : super(initialState) {
    on<ListInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ListInitialEvent event,
    Emitter<ListState> emit,
  ) async {
    emit(state.copyWith(
        listModelObj: state.listModelObj
            ?.copyWith(songlistItemList: fillSonglistItemList())));
  }

  List<SonglistItemModel> fillSonglistItemList() {
    return [
      SonglistItemModel(
          songNumber: "1",
          burning: "Burning",
          podvalCaplella: "Podval Caplella"),
      SonglistItemModel(
          songNumber: "2", burning: "Flashbacks", podvalCaplella: "Emika"),
      SonglistItemModel(
          songNumber: "3",
          burning: "Renaissance",
          podvalCaplella: "Podval Caplella")
    ];
  }
}
