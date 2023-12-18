import '../playlist_bottomsheet/widgets/playlist_item_widget.dart';
import 'bloc/playlist_bloc.dart';
import 'models/playlist_item_model.dart';
import 'models/playlist_model.dart';
import 'package:chauhan_s_application1/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class PlaylistBottomsheet extends StatelessWidget {
  const PlaylistBottomsheet({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<PlaylistBloc>(
      create: (context) => PlaylistBloc(PlaylistState(
        playlistModelObj: PlaylistModel(),
      ))
        ..add(PlaylistInitialEvent()),
      child: PlaylistBottomsheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SizedBox(
      height: 728.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 729.v,
              width: double.maxFinite,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.h,
                  top: 13.v,
                  right: 24.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: 0.445,
                      child: Container(
                        height: 5.v,
                        width: 35.h,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimaryContainer,
                          borderRadius: BorderRadius.circular(
                            2.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35.v),
                    _buildPlaylist(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPlaylist(BuildContext context) {
    return Expanded(
      child: BlocSelector<PlaylistBloc, PlaylistState, PlaylistModel?>(
        selector: (state) => state.playlistModelObj,
        builder: (context, playlistModelObj) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 16.v,
              );
            },
            itemCount: playlistModelObj?.playlistItemList.length ?? 0,
            itemBuilder: (context, index) {
              PlaylistItemModel model =
                  playlistModelObj?.playlistItemList[index] ??
                      PlaylistItemModel();
              return PlaylistItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }
}
