import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../navigator/mixin/back_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../util/constants/app_constants.dart';
import '../../vm/lists/likes_vm.dart';
import '../../widget/general/labels.dart';
import '../../widget/general/list_items.dart';
import '../../widget/progress/line_progress.dart';
import '../../widget/provider/provider_widget.dart';
import '../songs/presentor_screen.dart';

class LikesScreen extends StatefulWidget {
  static const String routeName = RouteNames.likesScreen;

  const LikesScreen({Key? key}) : super(key: key);

  @override
  LikesScreenState createState() => LikesScreenState();
}

@visibleForTesting
class LikesScreenState extends State<LikesScreen>
    with BackNavigatorMixin
    implements LikesNavigator {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return ProviderWidget<LikesVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) => Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.likesTitle),
        ),
        body: Container(
          height: size!.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, ThemeColors.accent, Colors.black],
            ),
          ),
          child: viewModel.isBusy
              ? const ListLoading()
              : viewModel.likes!.isNotEmpty
                  ? listContainer(context, viewModel)
                  : const NoDataToShow(
                      title: AppConstants.itsEmptyHere1,
                      description: AppConstants.itsEmptyHereBody4,
                    ),
        ),
      ),
    );
  }

  Widget listContainer(BuildContext context, LikesVm viewModel) {
    return Scrollbar(
      thickness: 10,
      radius: const Radius.circular(20),
      //controller: viewModel.songScroller,
      child: ListView.builder(
        //controller: viewModel.songScroller,
        itemCount: viewModel.likes!.length,
        padding: EdgeInsets.all(
          size!.height * 0.0082,
        ),
        itemBuilder: (context, index) => SongItem(
          song: viewModel.likes![index],
          height: size!.height,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PresentorScreen(
                    books: viewModel.books,
                    song: viewModel.likes![index],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}