import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/view_models/signout_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  final bool _notification = false;

  // void _onNotificationChanged(bool? newValue) {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    /*print(ref.watch(playbackConfigProvider).autoplay);
      print(ref.exists(playbackConfigProvider));
      ref.listen(playbackConfigProvider, (previous, next) {
      print(previous!.autoplay);
      print(next);
    });*/
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth:
                size.width > Breakpoints.md ? size.width * 0.5 : size.width,
          ),
          child: ListView(
            children: [
              // SwitchListTile.adaptive(
              //   value: context.watch<VideoConfigProvider>().isMuted,
              //   onChanged: (value) {
              //     context.read<VideoConfigProvider>().toggleIsMuted();
              //   },
              //   title: const Text('Muted - Provider'),
              //   subtitle: const Text('Enable notifications'),
              // ),
              // SwitchListTile.adaptive(
              //   value: context.watch<VideoConfigProvider>().isAutoplay,
              //   onChanged: (value) {
              //     context.read<VideoConfigProvider>().toggleIsAutoplay();
              //   },
              //   title: const Text('Autoplay - Provider'),
              //   subtitle: const Text('Enable notifications'),
              // ),
              // ValueListenableBuilder(
              //   valueListenable: darkModeConfig,
              //   builder: (context, value, child) => SwitchListTile.adaptive(
              //     value: value,
              //     onChanged: (value) {
              //       darkModeConfig.value = !darkModeConfig.value;
              //     },
              //     title: const Text('Dark Mode - ValueListnerbleBuilder'),
              //     subtitle: const Text('Enable notifications'),
              //   ),
              // ),
              // ValueListenableBuilder(
              //   valueListenable: videoConfigValue,
              //   builder: (context, value, child) => SwitchListTile.adaptive(
              //     value: value,
              //     onChanged: (value) {
              //       videoConfigValue.value = !value;
              //     },
              //     title: const Text('ValueNotifier - ValueListnerbleBuilder'),
              //     subtitle: const Text('Enable notifications'),
              //   ),
              // ),
              // AnimatedBuilder(
              //   animation: videoConfigValue,
              //   builder: (context, child) => SwitchListTile.adaptive(
              //     value: videoConfigValue.value,
              //     onChanged: (value) {
              //       videoConfigValue.value = !videoConfigValue.value;
              //     },
              //     title: const Text('ValueNotifier - AnimatedBuilder'),
              //     subtitle: const Text('Enable notifications'),
              //   ),
              // ),
              // AnimatedBuilder(
              //   animation: videoConfigNoti,
              //   builder: (context, child) => SwitchListTile.adaptive(
              //     value: videoConfigNoti.autoMute,
              //     onChanged: (value) => videoConfigNoti.toggleAutoMute(),
              //     title: const Text('Mute Video'),
              //     subtitle: const Text('Videos will be muted by default'),
              //   ),
              // ),

              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).muted,
                onChanged: (value) =>
                    {ref.read(playbackConfigProvider.notifier).setMuted(value)},
                title: const Text('Mute Video'),
                subtitle: const Text('Video will be muted by default'),
              ),

              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).autoplay,
                onChanged: (value) => {
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value)
                },
                title: const Text('Autoplay'),
                subtitle: const Text('Video will start playing automatically'),
              ),
              SwitchListTile.adaptive(
                value: false,
                onChanged: (value) {},
                title: const Text('Enable notifications'),
                subtitle: const Text('Enable notifications'),
              ),
              // CheckboxListTile(
              //   value: _notification,
              //   onChanged: _onNotificationChanged,
              //   title: const Text('Enable notifications'),
              //   checkColor: Colors.white,
              //   activeColor: Colors.black,
              // ),
              ListTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );

                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  final booking = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          appBarTheme: const AppBarTheme(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (kDebugMode) {
                    print(booking);
                  }
                },
                title: const Text('What is your birthday?'),
              ),
              ListTile(
                onTap: () => showAboutDialog(
                  context: context,
                  applicationVersion: '1.0',
                  applicationLegalese:
                      "All rights. reserved. Please don't copy me",
                  applicationName: 'Techok',
                  children: [
                    const Text(
                      'hihihihi',
                    )
                  ],
                ),
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'about this app',
                ),
              ),
              const AboutListTile(),
              ListTile(
                title: const Text('Log out (iOS)'),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('T^T'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ref.read(signOutProvider.notifier).signOut(context);
                          },
                          isDestructiveAction: true,
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Log out (iOS / Bottom)'),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('T^T'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          isDestructiveAction: true,
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Log out (iOS / BottomSheet)'),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: size.width * 0.4,
                      ),
                      child: CupertinoActionSheet(
                        title: const Text('Are you sure?'),
                        message: const Text("Please don't go"),
                        // cancelButton: const Text('cancel'),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Not log out'),
                          ),
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Not log out'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Log out (Android)'),
                textColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      icon: const FaIcon(
                        FontAwesomeIcons.skull,
                      ),
                      title: const Text('Are you sure?'),
                      content: const Text('T^T'),
                      actions: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const FaIcon(FontAwesomeIcons.car),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const FaIcon(FontAwesomeIcons.expeditedssl),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
