// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import 'newreleaseslist_item_model.dart';

/// This class defines the variables used in the [home_page_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class HomePageModel extends Equatable {
  HomePageModel({this.newreleaseslistItemList = const []}) {}

  List<NewreleaseslistItemModel> newreleaseslistItemList;

  HomePageModel copyWith(
      {List<NewreleaseslistItemModel>? newreleaseslistItemList}) {
    return HomePageModel(
      newreleaseslistItemList:
          newreleaseslistItemList ?? this.newreleaseslistItemList,
    );
  }

  @override
  List<Object?> get props => [newreleaseslistItemList];
}
