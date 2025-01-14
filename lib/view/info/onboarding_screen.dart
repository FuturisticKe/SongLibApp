import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onboarding/onboarding.dart';
import 'package:songlib/theme/theme_colors.dart';

import '../../navigator/main_navigator.dart';
import '../../navigator/route_names.dart';
import '../../viewmodel/onboarding_vm.dart';
import '../../widget/provider/provider_widget.dart';

part 'onboarding_widget.dart';

/// Timed Welcome screen
class OnboardingScreen extends StatefulWidget {
  static const String routeName = RouteNames.onboardingScreen;
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

@visibleForTesting
class OnboardingScreenState extends State<OnboardingScreen>
    implements OnboardingNavigator {
  OnboardingVm? vm;
  Size? size;
  late Material materialButton;
  late int index;
  final onboardingTitles = [
    'Welcome to SongLib',
    'Draft a song',
    'List songs',
    'Your song list',
    'Simple presentation',
  ];
  List<PageModel> onboardingPages = [];

  @override
  void initState() {
    super.initState();
    materialButton = skipButton();
    index = 0;
  }

  Material skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: Colors.white,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 4;
            setIndex(4);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'SKIP',
            style:
                TextStyle(color: ThemeColors.primaryDark, letterSpacing: 1.0),
          ),
        ),
      ),
    );
  }

  Material get finishButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: ThemeColors.primaryDark,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () => vm!.finishOnboarding(),
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'FINISH',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    onboardingPages = [
      PageModel(
        widget: OnboardingWidget(
          size: size!,
          image: 'screen1',
          description:
              'Access everything at a glance\nLong press a song for options',
        ),
      ),
      PageModel(
        widget: OnboardingWidget(
          size: size!,
          image: 'screen2',
          description: 'Write your own songs on the go',
        ),
      ),
      PageModel(
        widget: OnboardingWidget(
          size: size!,
          image: 'screen3',
          description: 'Add a song list\nLong press a list for options',
        ),
      ),
      PageModel(
        widget: OnboardingWidget(
          size: size!,
          image: 'screen4',
          description: 'Rename or Delete your list\nAdd songs to your list',
        ),
      ),
      PageModel(
        widget: OnboardingWidget(
          size: size!,
          image: 'screen5',
          description: 'Double tap verse to Share\nLong Press Verse to Copy',
        ),
      ),
    ];
    return ProviderWidget<OnboardingVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) {
        vm = viewModel;
        return screenWidget(context);
      },
    );
  }

  Widget screenWidget(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        pages: onboardingPages,
        onPageChange: (int pageIndex) {
          index = pageIndex;
        },
        startPageIndex: 0,
        footerBuilder: (context, dragDistance, pagesLength, setIndex) {
          return Container(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 50),
            decoration: const BoxDecoration(
              color: ThemeColors.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          indicatorDesign: IndicatorDesign.line(
                            lineDesign: LineDesign(
                              lineType: DesignType.line_uniform,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        onboardingTitles[index],
                        style: pageTitleStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                index == pagesLength - 1
                    ? finishButton
                    : skipButton(setIndex: setIndex)
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void goToHome() => MainNavigatorWidget.of(context).goToHome();
}
