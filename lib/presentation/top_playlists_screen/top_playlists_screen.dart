import '../top_playlists_screen/widgets/topplaylist_item_widget.dart';
import 'bloc/top_playlists_bloc.dart';
import 'models/top_playlists_model.dart';
import 'models/topplaylist_item_model.dart';
import 'package:chauhan_s_application1/core/app_export.dart';
import 'package:chauhan_s_application1/presentation/favorites_screen/favorites_screen.dart';
import 'package:chauhan_s_application1/presentation/top_playlists_screen/top_playlists_screen.dart';
import 'package:chauhan_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:chauhan_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:chauhan_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:chauhan_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:chauhan_s_application1/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class TopPlaylistsScreen extends StatelessWidget {
  TopPlaylistsScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<TopPlaylistsBloc>(
        create: (context) => TopPlaylistsBloc(
            TopPlaylistsState(topPlaylistsModelObj: TopPlaylistsModel()))
          ..add(TopPlaylistsInitialEvent()),
        child: TopPlaylistsScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 20.v),
                  _buildTopPlaylist(context)
                ])),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 53.v,
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 24.h, top: 14.v, bottom: 15.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "lbl_top_playlists".tr),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMenu,
              margin: EdgeInsets.fromLTRB(24.h, 14.v, 24.h, 15.v))
        ]);
  }

  /// Section Widget
  Widget _buildTopPlaylist(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: BlocSelector<TopPlaylistsBloc, TopPlaylistsState,
                    TopPlaylistsModel?>(
                selector: (state) => state.topPlaylistsModelObj,
                builder: (context, topPlaylistsModelObj) {
                  return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 24.v);
                      },
                      itemCount:
                          topPlaylistsModelObj?.topplaylistItemList.length ?? 0,
                      itemBuilder: (context, index) {
                        TopplaylistItemModel model =
                            topPlaylistsModelObj?.topplaylistItemList[index] ??
                                TopplaylistItemModel();
                        return TopplaylistItemWidget(model,
                            onTapImgRenaissance: () {
                          onTapImgRenaissance(context);
                        });
                      });
                })));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return "/";
      case BottomBarEnum.Top:
        return AppRoutes.topPlaylistsScreen;
      case BottomBarEnum.Favorites:
        return AppRoutes.favoritesScreen;
      case BottomBarEnum.Search:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.topPlaylistsScreen:
        return TopPlaylistsScreen.builder(context);
      case AppRoutes.favoritesScreen:
        return FavoritesScreen.builder(context);
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the listScreen when the action is triggered.
  onTapImgRenaissance(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.listScreen);
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }
}
