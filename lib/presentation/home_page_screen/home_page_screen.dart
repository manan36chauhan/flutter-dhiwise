import '../home_page_screen/widgets/newreleaseslist_item_widget.dart';
import 'bloc/home_page_bloc.dart';
import 'models/home_page_model.dart';
import 'models/newreleaseslist_item_model.dart';
import 'package:chauhan_s_application1/core/app_export.dart';
import 'package:chauhan_s_application1/presentation/favorites_screen/favorites_screen.dart';
import 'package:chauhan_s_application1/presentation/top_playlists_screen/top_playlists_screen.dart';
import 'package:chauhan_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:chauhan_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:chauhan_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:chauhan_s_application1/widgets/custom_bottom_bar.dart';
import 'package:chauhan_s_application1/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:chauhan_s_application1/presentation/playlist_bottomsheet/playlist_bottomsheet.dart';

// ignore_for_file: must_be_immutable
class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<HomePageBloc>(
        create: (context) =>
            HomePageBloc(HomePageState(homePageModelObj: HomePageModel()))
              ..add(HomePageInitialEvent()),
        child: HomePageScreen());
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
                  SizedBox(height: 26.v),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 24.h, right: 24.h, bottom: 5.v),
                              child: Column(children: [
                                Container(
                                    width: 243.h,
                                    margin: EdgeInsets.only(
                                        left: 49.h, right: 50.h),
                                    child: Text(
                                        "msg_listen_to_music_without".tr,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.headlineMedium!
                                            .copyWith(height: 1.50))),
                                SizedBox(height: 34.v),
                                CustomElevatedButton(
                                    height: 40.v,
                                    width: 236.h,
                                    text: "lbl_trial_version".tr,
                                    buttonStyle: CustomButtonStyles
                                        .fillOnPrimaryContainerTL20,
                                    buttonTextStyle:
                                        CustomTextStyles.bodyLargeBlack900),
                                SizedBox(height: 41.v),
                                Text("msg_free_for_3_months".tr,
                                    style: CustomTextStyles
                                        .bodyMediumOnPrimaryContainer),
                                SizedBox(height: 44.v),
                                _buildNewReleases(context)
                              ]))))
                ])),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        centerTitle: true,
        title: AppbarTitle(text: "lbl_dashboard".tr),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMenu,
              margin: EdgeInsets.fromLTRB(24.h, 14.v, 24.h, 13.v))
        ]);
  }

  /// Section Widget
  Widget _buildNewReleasesList(BuildContext context) {
    return SizedBox(
        height: 230.v,
        child: BlocSelector<HomePageBloc, HomePageState, HomePageModel?>(
            selector: (state) => state.homePageModelObj,
            builder: (context, homePageModelObj) {
              return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 24.h);
                  },
                  itemCount:
                      homePageModelObj?.newreleaseslistItemList.length ?? 0,
                  itemBuilder: (context, index) {
                    NewreleaseslistItemModel model =
                        homePageModelObj?.newreleaseslistItemList[index] ??
                            NewreleaseslistItemModel();
                    return NewreleaseslistItemWidget(model);
                  });
            }));
  }

  /// Section Widget
  Widget _buildNewReleases(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("lbl_new_releases".tr, style: theme.textTheme.headlineSmall),
        GestureDetector(
            onTap: () {
              onTapTxtViewAll(context);
            },
            child: Padding(
                padding: EdgeInsets.only(top: 5.v, bottom: 6.v),
                child: Text("lbl_view_all".tr,
                    style: CustomTextStyles.bodyMediumOnPrimaryContainer)))
      ]),
      SizedBox(height: 20.v),
      _buildNewReleasesList(context)
    ]);
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

  /// Displays a bottom sheet widget using the [showModalBottomSheet] method
  /// of the [Scaffold] class with [isScrollControlled] set to true.
  ///
  /// The bottom sheet is built using the [PlaylistBottomsheet]
  /// class and the [builder] method of the bottom sheet is passed the
  /// [BuildContext] object.
  onTapTxtViewAll(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => PlaylistBottomsheet.builder(context),
        isScrollControlled: true);
  }
}
